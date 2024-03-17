aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-s3-from-existing-manage-compress-dir"
    function_name = "lambda-s3-from-existing-manage-compress-dir"
    handler       = "handler.handler"
    deployment_type = {
      from_s3_existing_new_file = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-s3-from-existing-manage-compress-dir"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-s3-from-existing-manage-compress-dir"
  }
]

lambda_host_config = [
  {
    name = "lambda-s3-from-existing-manage-compress-dir"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
