aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

verification_message_template_config = {
  name                 = "userpool1"
  default_email_option = "CONFIRM_WITH_CODE"
  sms_message          = "Your verification code is {####}."
  email_message        = "Your verification code is {####}."
}
