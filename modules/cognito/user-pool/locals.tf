locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.user_pool_config != null

  // Specific functionalities with feature flags
  is_email_verification_enabled = !local.is_module_enabled ? false : var.email_verification_config != null
  is_sms_verification_enabled   = !local.is_module_enabled ? false : var.sms_verification_config != null
  is_mfa_enabled                = !local.is_module_enabled ? false : var.mfa_configuration_config != null

  // Normalization and mapping.
  // [1.] Core user-pool configuration.
  user_pool = !local.is_module_enabled ? null : [var.user_pool_config]
  user_pool_config_normalised = !local.is_module_enabled ? [] : [
    for cfg in local.user_pool : {
      name                     = trimspace(cfg["name"])
      user_pool_name           = cfg["user_pool_name"] == null ? trimspace(cfg["name"]) : trimspace(cfg["user_pool_name"])
      alias_attributes         = cfg["alias_attributes"] == null ? null : cfg["alias_attributes"]
      username_attributes      = cfg["username_attributes"] == null ? null : cfg["username_attributes"]
      deletion_protection      = cfg["deletion_protection_enabled"] == null ? "INACTIVE" : cfg["deletion_protection_enabled"] ? "ENABLED" : "INACTIVE"
      auto_verified_attributes = cfg["auto_verified_attributes"] == null ? [] : cfg["auto_verified_attributes"]
      username_configuration = cfg["is_username_case_sensitive"] ? {
        case_sensitive = true
        } : {
        case_sensitive = false
      }
      // These options are mutually exclusive.
      is_username_attributes_enabled = cfg["username_attributes"] == null ? false : length(cfg["username_attributes"]) > 0
      is_alias_attributes_enabled    = cfg["alias_attributes"] == null ? false : length(cfg["alias_attributes"]) > 0 && cfg["username_attributes"] == null
  }]

  user_pool_config = !local.is_module_enabled ? {} : {
    for cfg in local.user_pool_config_normalised : cfg["name"] => cfg
  }

  // [2.] Email verification configuration.
  email_verification = !local.is_email_verification_enabled ? null : [var.email_verification_config]
  email_verification_config_normalised = !local.is_email_verification_enabled ? [] : [
    for cfg in local.email_verification : {
      name                       = trimspace(cfg["name"])
      email_verification_subject = cfg["email_verification_subject"]
      email_verification_message = cfg["email_verification_message"]
  }]

  email_verification_config = !local.is_email_verification_enabled ? {} : {
    for cfg in local.email_verification_config_normalised : cfg["name"] => cfg
  }

  // [3.] SMS verification configuration.
  sms_verification = !local.is_sms_verification_enabled ? null : [var.sms_verification_config]
  sms_verification_config_normalised = !local.is_sms_verification_enabled ? [] : [
    for cfg in local.sms_verification : {
      name                       = trimspace(cfg["name"])
      sms_verification_message   = cfg["sms_verification_message"]
      sms_authentication_message = cfg["sms_authentication_message"]
  }]

  sms_verification_config = !local.is_sms_verification_enabled ? {} : {
    for cfg in local.sms_verification_config_normalised : cfg["name"] => cfg
  }

  // [4.] MFA configuration.
  mfa_configuration = !local.is_mfa_enabled ? null : [var.mfa_configuration_config]
  mfa_configuration_config_normalised = !local.is_mfa_enabled ? [] : [
    for cfg in local.mfa_configuration : {
      name              = trimspace(cfg["name"])
      mfa_configuration = cfg["enable_mfa"] ? "ON" : cfg["disable_mfa"] ? "OFF" : cfg["enable_optional_mfa"] ? "OPTIONAL" : "OFF"
  }]

  mfa_configuration_config = !local.is_mfa_enabled ? {} : {
    for cfg in local.mfa_configuration_config_normalised : cfg["name"] => cfg
  }
}
