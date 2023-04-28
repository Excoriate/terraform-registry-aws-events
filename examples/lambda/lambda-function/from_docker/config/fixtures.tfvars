aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-docker"
    function_name = "simple-basic-function-docker"
    handler       = "handler.handler"
    deployment_type = {
      from_docker = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-func-docker"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-docker"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-docker"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
