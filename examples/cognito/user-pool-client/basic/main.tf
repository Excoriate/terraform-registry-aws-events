module "main_module" {
  source     = "../../../../modules/cognito/user-pool-client"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_client_config = [
    {
      name         = "userpoolclient1"
      user_pool_id = aws_cognito_user_pool.pool.id
    }
  ]
  tags = var.tags
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}
