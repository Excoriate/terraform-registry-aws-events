aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name             = "userpool1"
  alias_attributes = ["email", "phone_number", "preferred_username"]
}
