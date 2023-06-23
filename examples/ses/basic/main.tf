module "main_module" {
  source     = "../../../modules/ses"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  ses_config                   = var.ses_config
  ses_verification_config      = var.ses_verification_config
  ses_validation_config        = var.ses_validation_config
  ses_notification_config      = var.ses_notification_config
  ses_template_config          = var.ses_template_config
  ses_event_destination_config = var.ses_event_destination_config

  tags = var.tags
}
