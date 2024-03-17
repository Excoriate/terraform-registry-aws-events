aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name   = "ses-config1"
  domain = "sandbox.4id.network"
}

ses_verification_config = {
  name    = "ses-config1"
  ttl     = 300
  enabled = true
}
