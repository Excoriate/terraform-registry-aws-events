aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    runtime       = "nodejs18.x"
    timeout       = 20
    deployment_type = {
      from_archive = true
    }
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

lambda_archive_config = [
  {
    name         = "lambda-func-test"
    source_dir   = "." // Current directory
    package_name = "deployed_from_archive_dir_excluded_terraform.zip"
    excluded_files = [
      ".terraform",
      ".git",
      ".gitignore",
      ".DS_Store",
      "README.md",
      "LICENSE",
      "config",
      "output.tf",
      "variables.tf",
      "providers.tf",
      "terraform.tfstate",
      "terraform.tfstate.backup",
      "versions.tf",
    "main.tf", ]
  }
]
