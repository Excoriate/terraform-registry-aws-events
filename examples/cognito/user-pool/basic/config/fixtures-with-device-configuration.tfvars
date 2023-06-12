aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

device_configuration = {
  name                                  = "userpool1"
  challenge_required_on_new_device      = false
  device_only_remembered_on_user_prompt = false
}
