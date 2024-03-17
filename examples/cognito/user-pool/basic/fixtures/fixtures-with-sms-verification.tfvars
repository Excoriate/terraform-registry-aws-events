aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

sms_verification_config = {
  name                       = "userpool1"
  sms_authentication_message = "Your authentication code is {####}. Expires in 10 minutes."
  sms_verification_message   = "Your verification code is {####}. Expires in 10 minutes."
}
