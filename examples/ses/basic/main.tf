module "main_module" {
  source     = "../../../modules/ses"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  ses_config              = var.ses_config
  ses_verification_config = var.ses_verification_config

  tags = var.tags
}
