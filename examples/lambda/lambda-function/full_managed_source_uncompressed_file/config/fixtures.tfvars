aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-full-managed-uncompressed-file"
    function_name = "lambda-full-managed-uncompressed-file"
    handler       = "handler.handler"
    deployment_type = {
      full_managed = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-full-managed-uncompressed-file"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-full-managed-uncompressed-file"
  }
]

lambda_host_config = [
  {
    name = "lambda-full-managed-uncompressed-file"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
