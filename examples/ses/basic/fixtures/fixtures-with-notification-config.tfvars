aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name                    = "ses-config1"
  domain                  = "sandbox.4id.network"
  create_domain_mail_from = true
}

ses_notification_config = {
  name                     = "ses-config1"
  notification_type        = "Bounce"
  include_original_headers = true
}
