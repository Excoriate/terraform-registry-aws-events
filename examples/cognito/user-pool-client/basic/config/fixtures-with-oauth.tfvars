aws_region = "us-east-1"
is_enabled = true

oauth_config = [
  {
    name                                 = "userpoolclient1"
    allowed_oauth_flows                  = ["code"]
    allowed_oauth_scopes                 = ["openid", "email"] // openid scope is added
    allowed_oauth_flows_user_pool_client = false
    callback_urls                        = ["https://example.com"]
  }
]
