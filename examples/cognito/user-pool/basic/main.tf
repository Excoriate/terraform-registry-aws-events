module "main_module" {
  source     = "../../../../modules/cognito/user-pool"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_config          = var.user_pool_config
  email_verification_config = var.email_verification_config
  mfa_configuration_config  = var.mfa_configuration_config
  sms_verification_config   = var.sms_verification_config
}
