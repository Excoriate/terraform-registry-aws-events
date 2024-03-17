aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name                = "userpool1"
  username_attributes = ["email", "phone_number"]
}

schema_attributes_config = [
  {
    name                     = "userpool1"
    attribute_name           = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
    string_attribute_constraints = {
      max_length = "2048"
      min_length = "0"
    }
  }
]
