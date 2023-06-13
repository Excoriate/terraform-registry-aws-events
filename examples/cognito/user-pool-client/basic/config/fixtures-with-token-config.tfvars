aws_region = "us-east-1"
is_enabled = true

token_config = [
  {
    name                   = "userpoolclient1"
    id_token_validity      = 60
    access_token_validity  = 60
    refresh_token_validity = 60
    token_validity_units = {
      id_token      = "minutes"
      access_token  = "minutes"
      refresh_token = "minutes"
    }
  }
]
