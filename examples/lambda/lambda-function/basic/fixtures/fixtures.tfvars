aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    filename      = "lambda.zip"
  }
]

lambda_observability_config = [
  {
    name         = "lambda-func-test"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
