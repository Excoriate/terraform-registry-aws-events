aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

lambda_permissions_config = {
  name          = "eventbridge-role-1"
  enable_lambda = true
  lambda_arns   = ["arn:aws:lambda:us-east-1:123456789012:function:my-function"]
}
