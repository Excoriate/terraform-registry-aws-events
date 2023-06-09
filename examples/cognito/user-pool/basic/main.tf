module "main_module" {
  source     = "../../../../modules/cognito/user-pool"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_config                     = var.user_pool_config
  email_verification_config            = var.email_verification_config
  mfa_configuration_config             = var.mfa_configuration_config
  sms_verification_config              = var.sms_verification_config
  admin_create_user_config             = var.admin_create_user_config
  account_recovery_config              = var.account_recovery_config
  device_configuration                 = var.device_configuration
  email_configuration                  = var.email_configuration
  sms_configuration                    = var.sms_configuration
  password_policy_config               = var.password_policy_config
  schema_attributes_config             = var.schema_attributes_config
  verification_message_template_config = var.verification_message_template_config
  lambda_config                        = var.lambda_config
}
