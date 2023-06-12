resource "aws_cognito_user_pool" "this" {
  for_each                 = local.user_pool_config
  name                     = each.value["user_pool_name"]
  alias_attributes         = each.value["is_alias_attributes_enabled"] ? each.value["alias_attributes"] : null
  username_attributes      = each.value["is_username_attributes_enabled"] ? each.value["username_attributes"] : null
  deletion_protection      = each.value["deletion_protection"]
  auto_verified_attributes = each.value["auto_verified_attributes"]

  // Email verification options
  email_verification_message = !local.is_email_verification_enabled ? null : local.email_verification_config[each.key] == null ? null : lookup(local.email_verification_config[each.key], "email_verification_message", null)
  email_verification_subject = !local.is_email_verification_enabled ? null : local.email_verification_config[each.key] == null ? null : lookup(local.email_verification_config[each.key], "email_verification_subject", null)

  // SMS verification options
  sms_authentication_message = !local.is_sms_verification_enabled ? null : local.sms_verification_config[each.key] == null ? null : lookup(local.sms_verification_config[each.key], "sms_authentication_message", null)
  sms_verification_message   = !local.is_sms_verification_enabled ? null : local.sms_verification_config[each.key] == null ? null : lookup(local.sms_verification_config[each.key], "sms_verification_message", null)

  // MFA configuration
  mfa_configuration = !local.is_mfa_enabled ? null : local.mfa_configuration_config[each.key] == null ? null : lookup(local.mfa_configuration_config[each.key], "mfa_configuration", "OFF")

  dynamic "software_token_mfa_configuration" {
    for_each = !local.is_mfa_enabled ? {} : local.mfa_configuration_config[each.key] == null ? {} : { software_token_mfa_configuration = local.mfa_configuration_config[each.key] }
    content {
      enabled = software_token_mfa_configuration.value["allow_software_mfa_token"]
    }
  }

  // #################################################
  // Username configuration
  // #################################################
  dynamic "username_configuration" {
    for_each = each.value["username_configuration"]
    iterator = cfg
    content {
      case_sensitive = cfg.value
    }
  }

  // #################################################
  // Admin create user configuration
  // #################################################
  dynamic "admin_create_user_config" {
    for_each = !local.is_admin_create_user_enabled ? {} : local.admin_create_user_config[each.key] != null ? { admin_create_user_config = local.admin_create_user_config[each.key] } : {}
    content {
      allow_admin_create_user_only = admin_create_user_config.value["allow_admin_create_user_only"]
      dynamic "invite_message_template" {
        for_each = admin_create_user_config.value["invite_message_template"] != null ? { invite_message_template = admin_create_user_config.value["invite_message_template"] } : {}
        content {
          email_message = invite_message_template.value["email_message"]
          email_subject = invite_message_template.value["email_subject"]
          sms_message   = invite_message_template.value["sms_message"]
        }
      }
    }
  }

  // #################################################
  // Account recovery configuration
  // #################################################
  dynamic "account_recovery_setting" {
    for_each = !local.is_account_recovery_enabled ? {} : local.account_recovery_config[each.key] == null ? {} : { account_recovery_setting = local.account_recovery_config[each.key] }
    content {
      dynamic "recovery_mechanism" {
        for_each = account_recovery_setting.value["recovery_mechanisms"] // changed from "recovery_mechanism" to "recovery_mechanisms"
        iterator = cfg
        content {
          name     = cfg.value["name"]
          priority = cfg.value["priority"]
        }
      }
    }
  }

  // #################################################
  // Device Configuration
  // #################################################
  dynamic "device_configuration" {
    for_each = !local.is_device_configuration_enabled ? {} : local.device_configuration_config[each.key] == null ? {} : { device_configuration = local.device_configuration_config[each.key] }
    content {
      challenge_required_on_new_device      = device_configuration.value["challenge_required_on_new_device"]
      device_only_remembered_on_user_prompt = device_configuration.value["device_only_remembered_on_user_prompt"]
    }
  }

  // #################################################
  // Email configuration
  // #################################################
  dynamic "email_configuration" {
    for_each = !local.is_email_configuration_enabled ? {} : local.email_configuration_config[each.key] == null ? {} : {
      email_configuration = local.email_configuration_config[each.key]
    }
    content {
      configuration_set      = email_configuration.value["configuration_set"]
      email_sending_account  = email_configuration.value["email_sending_account"]
      from_email_address     = email_configuration.value["from_email_address"]
      reply_to_email_address = email_configuration.value["reply_to_email_address"]
      source_arn             = email_configuration.value["source_arn"]
    }
  }

  // #################################################
  // SMS configuration
  // #################################################
  dynamic "sms_configuration" {
    for_each = !local.is_sms_configuration_enabled ? {} : local.sms_configuration_config[each.key] == null ? {} : { sms_configuration = local.sms_configuration_config[each.key] }
    content {
      external_id    = sms_configuration.value["external_id"]
      sns_caller_arn = sms_configuration.value["sns_caller_arn"]
      sns_region     = sms_configuration.value["sns_region"]
    }
  }

  // #################################################
  // Password policy
  // #################################################
  dynamic "password_policy" {
    for_each = !local.is_password_policy_enabled ? {} : local.password_policy_config[each.key] == null ? {} : { password_policy = local.password_policy_config[each.key] }
    content {
      minimum_length                   = password_policy.value["minimum_length"]
      require_numbers                  = password_policy.value["require_numbers"]
      require_symbols                  = password_policy.value["require_symbols"]
      temporary_password_validity_days = password_policy.value["temporary_password_validity_days"]
      require_lowercase                = password_policy.value["require_lowercase"]
      require_uppercase                = password_policy.value["require_uppercase"]
    }
  }

}
