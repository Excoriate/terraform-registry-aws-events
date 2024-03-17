aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name                    = "ses-config1"
  domain                  = "sandbox.4id.network"
  create_domain_mail_from = true
  emails = [
    {
      address = "test1"
      enabled = true
    },
    {
      address = "test2@sandbox.4id.network"
      enabled = true
    },
    {
      address = "test4"
      enabled = false
    },
    {
      address = "test5"
    }
  ]
}
