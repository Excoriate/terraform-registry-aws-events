aws_region = "us-east-1"
is_enabled = true

ses_config = {
  name                    = "ses-config1"
  domain                  = "sandbox.4id.network"
  create_domain_mail_from = true
}

ses_template_config = [
  {
    name    = "ses-config1"
    subject = "Test subject"
    html    = "<h1>Test HTML</h1>"
    text    = "Test text"
  },
  {
    name    = "ses-config2"
    subject = "Test subject 2"
    html    = "<h1>Test HTML</h1>"
    text    = "Test text"
  },
  {
    name    = "ses-config3"
    subject = "Test subject 3"
    html    = "<h1>Test HTML</h1>"
    text    = "Test text"
  }
]
