locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.user_pool_config != null

  // Specific functionalities with feature flags
  is_email_verification_enabled            = !local.is_module_enabled ? false : var.email_verification_config != null
  is_sms_verification_enabled              = !local.is_module_enabled ? false : var.sms_verification_config != null
  is_mfa_enabled                           = !local.is_module_enabled ? false : var.mfa_configuration_config != null
  is_admin_create_user_enabled             = !local.is_module_enabled ? false : var.admin_create_user_config != null
  is_account_recovery_enabled              = !local.is_module_enabled ? false : var.account_recovery_config != null
  is_device_configuration_enabled          = !local.is_module_enabled ? false : var.device_configuration != null
  is_email_configuration_enabled           = !local.is_module_enabled ? false : var.email_configuration != null
  is_sms_configuration_enabled             = !local.is_module_enabled ? false : var.sms_configuration != null
  is_password_policy_enabled               = !local.is_module_enabled ? false : var.password_policy_config != null
  is_schema_attributes_enabled             = !local.is_module_enabled ? false : var.schema_attributes_config != null
  is_verification_message_template_enabled = !local.is_module_enabled ? false : var.verification_message_template_config != null

  // Normalization and mapping.
  // [1.] Core user-pool configuration.
  user_pool = !local.is_module_enabled ? null : [var.user_pool_config]
  user_pool_config_normalised = !local.is_module_enabled ? {} : {
    for cfg in local.user_pool : cfg["name"] => {
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
      user_pool_add_ons_security_mode               = cfg["user_pool_add_ons_security_mode"]
      attributes_require_verification_before_update = cfg["attributes_require_verification_before_update"]
      // These options are mutually exclusive.
      is_username_attributes_enabled = cfg["username_attributes"] == null ? false : length(cfg["username_attributes"]) > 0
      is_alias_attributes_enabled    = cfg["alias_attributes"] == null ? false : length(cfg["alias_attributes"]) > 0 && cfg["username_attributes"] == null
  } }

  user_pool_config = !local.is_module_enabled ? {} : local.user_pool_config_normalised

  // [2.] Email verification configuration.
  email_verification = !local.is_email_verification_enabled ? null : [var.email_verification_config]
  email_verification_config_normalised = !local.is_email_verification_enabled ? {} : {
    for cfg in local.email_verification : cfg["name"] => {
      name                       = trimspace(cfg["name"])
      email_verification_subject = cfg["email_verification_subject"]
      email_verification_message = cfg["email_verification_message"]
  } }

  email_verification_config = !local.is_email_verification_enabled ? {} : local.email_verification_config_normalised

  // [3.] SMS verification configuration.
  sms_verification = !local.is_sms_verification_enabled ? null : [var.sms_verification_config]
  sms_verification_config_normalised = !local.is_sms_verification_enabled ? {} : {
    for cfg in local.sms_verification : cfg["name"] => {
      name                       = trimspace(cfg["name"])
      sms_verification_message   = cfg["sms_verification_message"]
      sms_authentication_message = cfg["sms_authentication_message"]
  } }

  sms_verification_config = !local.is_sms_verification_enabled ? {} : local.sms_verification_config_normalised

  // [4.] MFA configuration.
  mfa_configuration = !local.is_mfa_enabled ? null : [var.mfa_configuration_config]
  mfa_configuration_config_normalised = !local.is_mfa_enabled ? {} : {
    for cfg in local.mfa_configuration : cfg["name"] => {
      name                     = trimspace(cfg["name"])
      mfa_configuration        = cfg["enable_mfa"] ? "ON" : cfg["disable_mfa"] ? "OFF" : cfg["enable_optional_mfa"] ? "OPTIONAL" : "OFF"
      allow_software_mfa_token = cfg["allow_software_mfa_token"] == null ? false : cfg["allow_software_mfa_token"]
  } }

  mfa_configuration_config = !local.is_mfa_enabled ? {} : local.mfa_configuration_config_normalised

  // [5.] Admin create user configuration.
  admin_create_user = !local.is_admin_create_user_enabled ? null : [var.admin_create_user_config]
  admin_create_user_config_normalised = !local.is_admin_create_user_enabled ? {} : {
    for cfg in local.admin_create_user : cfg["name"] => {
      name                         = trimspace(cfg["name"])
      allow_admin_create_user_only = cfg["allow_admin_create_user_only"]
      invite_message_template      = cfg["invite_message_template"]
  } }

  admin_create_user_config = !local.is_admin_create_user_enabled ? {} : local.admin_create_user_config_normalised

  // [6.] Account recovery configuration.
  account_recovery = !local.is_account_recovery_enabled ? null : [var.account_recovery_config]
  account_recovery_config_normalised = !local.is_account_recovery_enabled ? {} : {
    for cfg in local.account_recovery : cfg["name"] => {
      name                = trimspace(cfg["name"])
      recovery_mechanisms = cfg["recovery_mechanisms"]
  } }

  account_recovery_config = !local.is_account_recovery_enabled ? {} : local.account_recovery_config_normalised

  // [7.] Device configuration.
  device_configuration = !local.is_device_configuration_enabled ? null : [var.device_configuration]
  device_configuration_config_normalised = !local.is_device_configuration_enabled ? {} : {
    for cfg in local.device_configuration : cfg["name"] => {
      name                                  = trimspace(cfg["name"])
      device_only_remembered_on_user_prompt = cfg["device_only_remembered_on_user_prompt"]
      challenge_required_on_new_device      = cfg["challenge_required_on_new_device"]
  } }

  device_configuration_config = !local.is_device_configuration_enabled ? {} : local.device_configuration_config_normalised

  // [8.] Email configuration.
  email_configuration = !local.is_email_configuration_enabled ? null : [var.email_configuration]
  email_configuration_config_normalised = !local.is_email_configuration_enabled ? {} : {
    for cfg in local.email_configuration : cfg["name"] => {
      name                   = trimspace(cfg["name"])
      configuration_set      = cfg["configuration_set"]
      email_sending_account  = cfg["email_sending_account"]
      from_email_address     = cfg["from_email_address"]
      reply_to_email_address = cfg["reply_to_email_address"]
      source_arn             = cfg["source_arn"]
  } }

  email_configuration_config = !local.is_email_configuration_enabled ? {} : local.email_configuration_config_normalised

  // [9.] SMS configuration.
  sms_configuration = !local.is_sms_configuration_enabled ? null : [var.sms_configuration]
  sms_configuration_config_normalised = !local.is_sms_configuration_enabled ? {} : {
    for cfg in local.sms_configuration : cfg["name"] => {
      name           = trimspace(cfg["name"])
      external_id    = cfg["external_id"]
      sns_caller_arn = cfg["sns_caller_arn"]
      sns_region     = cfg["sns_region"]
  } }

  sms_configuration_config = !local.is_sms_configuration_enabled ? {} : local.sms_configuration_config_normalised

  // [10.] Password policy configuration.
  password_policy = !local.is_password_policy_enabled ? null : [var.password_policy_config]
  password_policy_config_normalised = !local.is_password_policy_enabled ? {} : {
    for cfg in local.password_policy : cfg["name"] => {
      name                             = trimspace(cfg["name"])
      minimum_length                   = cfg["minimum_length"]
      require_lowercase                = cfg["require_lowercase"]
      require_numbers                  = cfg["require_numbers"]
      require_symbols                  = cfg["require_symbols"]
      require_uppercase                = cfg["require_uppercase"]
      temporary_password_validity_days = cfg["temporary_password_validity_days"]
  } }

  password_policy_config = !local.is_password_policy_enabled ? {} : local.password_policy_config_normalised

  // [11.] Schema attributes
  schema_attributes = !local.is_schema_attributes_enabled ? null : var.schema_attributes_config
  schema_attributes_config_normalised = !local.is_schema_attributes_enabled ? [] : [
    for cfg in local.schema_attributes : {
      name                         = trimspace(cfg["name"])
      attribute_name               = cfg["attribute_name"]
      attribute_data_type          = cfg["attribute_data_type"]
      developer_only_attribute     = cfg["developer_only_attribute"]
      mutable                      = cfg["mutable"]
      required                     = cfg["required"]
      string_attribute_constraints = cfg["string_attribute_constraints"]
      number_attribute_constraints = cfg["number_attribute_constraints"]
  }]

  schema_attributes_config = !local.is_schema_attributes_enabled ? {} : {
    for cfg in local.schema_attributes_config_normalised : cfg["attribute_name"] => cfg
  }

  // [12.] Verification message template configuration.
  verification_message_template = !local.is_verification_message_template_enabled ? null : [var.verification_message_template_config]
  verification_message_template_config_normalised = !local.is_verification_message_template_enabled ? {} : {
    for cfg in local.verification_message_template : cfg["name"] => {
      name                  = trimspace(cfg["name"])
      default_email_option  = cfg["default_email_option"]
      email_message         = cfg["email_message"]
      email_message_by_link = cfg["email_message_by_link"]
      email_subject         = cfg["email_subject"]
      email_subject_by_link = cfg["email_subject_by_link"]
      sms_message           = cfg["sms_message"]
  } }

  verification_message_template_config = !local.is_verification_message_template_enabled ? {} : local.verification_message_template_config_normalised

}
