module "main_module" {
  source     = "../../../modules/ses"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration

  tags       = var.tags
  ses_config = var.ses_config
}
