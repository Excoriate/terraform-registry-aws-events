aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

sms_configuration = {
  name = "userpool1"
  sns_caller_arn = "arn:aws:iam::123456789012:role/role1"
  external_id = "123456789012"
  sns_region = "us-east-1"
}
