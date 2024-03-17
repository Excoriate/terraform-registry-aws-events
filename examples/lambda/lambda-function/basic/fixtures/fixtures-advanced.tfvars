aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    publish       = true
    filename      = "lambda.zip"
    #    provision_concurrency = 2
    runtime = "nodejs16.x"
    timeout = 10
  }
]

lambda_observability_config = [
  {
    name            = "lambda-func-test"
    logs_enabled    = true
    tracing_enabled = true
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
      "ENV_VAR3" = "value3"
    }
  }
]

lambda_alias_config = [
  {
    name       = "lambda-func-test"
    alias_name = "test"
  }
]
