aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

email_configuration = {
  name                   = "userpool1"
  from_email_address     = ""
  reply_to_email_address = ""
}
