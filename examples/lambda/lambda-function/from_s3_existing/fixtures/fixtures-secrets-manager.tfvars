aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-test-s3-from-existing"
    function_name = "lambda-test-s3-from-existing"
    handler       = "handler.handler"
    deployment_type = {
      from_s3_existing_file = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-test-s3-from-existing"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-test-s3-from-existing"
  }
]


lambda_host_config = [
  {
    name = "lambda-test-s3-from-existing"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
