aws_region = "us-east-1"
is_enabled = true

others_config = [
  {
    name                          = "userpoolclient1"
    auth_session_validity         = 3
    write_attributes              = ["email"]
    prevent_user_existence_errors = "ENABLED"
    read_attributes               = ["email"]
  }
]
