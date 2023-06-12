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

  dynamic "username_configuration" {
    for_each = each.value["username_configuration"]
    iterator = cfg
    content {
      case_sensitive = cfg.value
    }
  }
}
