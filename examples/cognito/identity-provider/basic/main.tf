module "main_module" {
  source     = "../../../../modules/cognito/identity-provider"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  identity_provider_config = [
    {
      name          = "userpooldomain1"
      user_pool_id  = aws_cognito_user_pool.pool.id
      provider_name = "LoginWithAmazon"
      provider_type = "LoginWithAmazon"
      provider_details = {
        client_id        = "client_id"
        client_secret    = "client_secret"
        authorize_scopes = "email, profile, openid" # Added authorize_scopes
      }
    },
    {
      name          = "userpooldomain2"
      user_pool_id  = aws_cognito_user_pool.pool2.id
      provider_name = "Google"
      provider_type = "Google"
      provider_details = {
        client_id        = "client_id"
        client_secret    = "client_secret"
        authorize_scopes = "email, profile, openid" # Added authorize_scopes
      }
    }
  ]

  identity_provider_optionals_config = var.identity_provider_optionals_config

  tags = var.tags
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}

resource "aws_cognito_user_pool" "pool2" {
  name = "userpool2"
}
