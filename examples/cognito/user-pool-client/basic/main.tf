module "main_module" {
  source     = "../../../../modules/cognito/user-pool-client"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_client_config = [
    {
      name         = "userpoolclient1"
      user_pool_id = aws_cognito_user_pool.pool.id
    },
    // mobile client
    {
      name         = "userpoolclient2"
      user_pool_id = aws_cognito_user_pool.pool.id
    }
  ]
  tags = var.tags

  oauth_config  = var.oauth_config
  token_config  = var.token_config
  others_config = var.others_config
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}
