aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

admin_create_user_config = {
  name                         = "userpool1"
  allow_admin_create_user_only = false
  invite_message_template = {
    email_message = "Your username is {username} and temporary password is {####}.",
    email_subject = "Your temporary password",
    sms_message   = "Your username is {username} and temporary password is {####}."
  }
}
