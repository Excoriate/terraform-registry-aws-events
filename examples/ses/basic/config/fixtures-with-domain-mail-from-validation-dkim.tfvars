aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name                    = "ses-config1"
  domain                  = "sandbox.4id.network"
  create_domain_mail_from = true
}

ses_verification_config = {
  name = "ses-config1"
}

ses_validation_config = {
  name                   = "ses-config1"
  enable_dkim_validation = true
}
