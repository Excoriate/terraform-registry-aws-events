aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name                    = "ses-config1"
  domain                  = "sandbox.4id.network"
  create_domain_mail_from = true
}

ses_event_destination_config = [
  {
    name           = "ses-config1"
    enabled        = true
    matching_types = ["bounce", "complaint"]
    cloudwatch_destination = {
      default_value  = true
      dimension_name = "ses"
      value_source   = "emailHeader"
    }
  },
  {
    name           = "ses-config2"
    enabled        = true
    matching_types = ["renderingFailure"]
    cloudwatch_destination = {
      default_value  = false
      dimension_name = "ses"
    }
  }
]
