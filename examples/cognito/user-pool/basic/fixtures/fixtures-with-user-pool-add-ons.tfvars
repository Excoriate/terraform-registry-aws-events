aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                            = "userpool1"
  username_attributes             = ["email"]
  is_username_case_sensitive      = false
  user_pool_add_ons_security_mode = "ENFORCED"
}
