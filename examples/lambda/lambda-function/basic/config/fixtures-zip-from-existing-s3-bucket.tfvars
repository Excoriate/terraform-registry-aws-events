aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    runtime       = "nodejs18.x"
    timeout       = 20
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
      "ENV_VAR" = "from-archive"
    }
  }
]

lambda_s3_from_bucket_config = [
  {
    name            = "lambda-func-test"
    source_zip_file = "lambda.zip"
    s3_bucket       = "lambda-bucket-test-iac-module"
  }
]
