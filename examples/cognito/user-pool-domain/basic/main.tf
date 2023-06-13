module "main_module" {
  source     = "../../../../modules/cognito/user-pool-domain"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_domain_config = [
    {
      name         = "userpooldomain1"
      user_pool_id = aws_cognito_user_pool.pool.id
      domain       = "exampleother"
    },
    // mobile client
    {
      name         = "userpooldomain2"
      user_pool_id = aws_cognito_user_pool.pool2.id
      domain       = "exampledifferent"
    }
  ]

  tags = var.tags
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}

resource "aws_cognito_user_pool" "pool2" {
  name = "userpool2"
}
