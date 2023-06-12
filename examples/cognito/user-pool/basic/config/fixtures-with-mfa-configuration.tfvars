aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

mfa_configuration_config = {
  name        = "userpool1",
  disable_mfa = true
}
