module "main_module" {
  source                         = "../../../../modules/lambda/lambda-function"
  is_enabled                     = var.is_enabled
  aws_region                     = var.aws_region
  lambda_config                  = var.lambda_config
  lambda_archive_config          = var.lambda_archive_config
  lambda_observability_config    = var.lambda_observability_config
  lambda_image_config            = var.lambda_image_config
  lambda_permissions_config      = var.lambda_permissions_config
  lambda_custom_policies_config  = var.lambda_custom_policies_config
  lambda_enable_eventbridge      = var.lambda_enable_eventbridge
  lambda_enable_secrets_manager  = var.lambda_enable_secrets_manager
  lambda_host_config             = var.lambda_host_config
  lambda_network_config          = var.lambda_network_config
  lambda_alias_config            = var.lambda_alias_config
  lambda_s3_from_existing_config = var.lambda_s3_from_existing_config
  lambda_s3_from_existing_new_file_config = [
    {
      name               = "lambda-s3-from-existing-manage-uncompressed"
      s3_bucket          = aws_s3_bucket.s3.id
      compress_from_file = "handler.js"
    }
  ]

  depends_on = [aws_s3_bucket.s3]
}

/*
  * Create a test S3 bucket to upload the lambda package.
*/
resource "aws_s3_bucket" "s3" {
  bucket        = local.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_string" "random_string" {
  length  = 2
  special = false
}

locals {
  output_package_name = "lambda-existing-uncompressed-file"
  s3_expected_key     = "deployment/${local.output_package_name}.zip"
  s3_bucket_name      = lower(format("from-s123-bucket-%s", random_string.random_string.result))
}

/*
  * Preventive mechanism to ensure that the bucket is 'alive'
  * before the lambda function is created.
*/
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [aws_s3_bucket.s3]
}
