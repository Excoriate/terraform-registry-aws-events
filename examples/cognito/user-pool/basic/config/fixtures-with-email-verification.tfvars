aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

email_verification_config = {
  name                       = "userpool1"
  email_verification_subject = "Your verification code"
  email_verification_message = "Your verification code is {####}."
}
