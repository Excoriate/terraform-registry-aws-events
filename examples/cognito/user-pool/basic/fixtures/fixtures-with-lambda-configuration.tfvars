aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

lambda_config = {
  name                           = "userpool1"
  create_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:create_auth_challenge"
  custom_message                 = "arn:aws:lambda:us-east-1:123456789012:function:custom_message"
  define_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:define_auth_challenge"
  post_authentication            = "arn:aws:lambda:us-east-1:123456789012:function:post_authentication"
  post_confirmation              = "arn:aws:lambda:us-east-1:123456789012:function:post_confirmation"
  pre_authentication             = "arn:aws:lambda:us-east-1:123456789012:function:pre_authentication"
  pre_sign_up                    = "arn:aws:lambda:us-east-1:123456789012:function:pre_sign_up"
  pre_token_generation           = "arn:aws:lambda:us-east-1:123456789012:function:pre_token_generation"
  user_migration                 = "arn:aws:lambda:us-east-1:123456789012:function:user_migration"
  verify_auth_challenge_response = "arn:aws:lambda:us-east-1:123456789012:function:verify_auth_challenge_response"
}
