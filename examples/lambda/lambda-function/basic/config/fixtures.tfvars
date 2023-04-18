aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name = "lambda-func-test"
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

lambda_custom_policies_config = [
  {
    name = "lambda-func-test"
    policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
    ]
  }
]
