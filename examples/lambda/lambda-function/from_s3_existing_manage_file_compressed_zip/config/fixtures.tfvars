aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-s3-from-existing-manage-file"
    function_name = "lambda-s3-from-existing-manage-file"
    handler       = "handler.handler"
    deployment_type = {
      from_s3_existing_new_file = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-s3-from-existing-manage-file"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-s3-from-existing-manage-file"
  }
]

lambda_host_config = [
  {
    name = "lambda-s3-from-existing-manage-file"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
