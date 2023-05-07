module "main_module" {
  source                        = "../../../../modules/lambda/lambda-function"
  is_enabled                    = var.is_enabled
  aws_region                    = var.aws_region
  lambda_config                 = var.lambda_config
  lambda_archive_config         = var.lambda_archive_config
  lambda_observability_config   = var.lambda_observability_config
  lambda_image_config           = var.lambda_image_config
  lambda_permissions_config     = var.lambda_permissions_config
  lambda_custom_policies_config = var.lambda_custom_policies_config
  lambda_enable_eventbridge     = var.lambda_enable_eventbridge
  lambda_enable_secrets_manager = [
    {
      name        = "lambda-test-s3-from-existing"
      secret_name = "/dev/secrets-manager-rotator/demo/my-demo-secret"
    }
  ]
  lambda_host_config    = var.lambda_host_config
  lambda_network_config = var.lambda_network_config
  lambda_alias_config   = var.lambda_alias_config
  lambda_s3_from_existing_config = [
    {
      name              = "lambda-test-s3-from-existing"
      s3_bucket         = aws_s3_bucket.s3.id
      s3_key            = aws_s3_object.upload_lambda_package.key
      s3_object_version = aws_s3_object.upload_lambda_package.version_id
    }
  ]
  lambda_s3_from_existing_new_file_config = var.lambda_s3_from_existing_new_file_config
  lambda_full_managed_config              = var.lambda_full_managed_config


  depends_on = [aws_s3_object.upload_lambda_package, aws_s3_bucket.s3]
}

/*
  * Create a test S3 bucket to upload the lambda package.
*/
resource "aws_s3_bucket" "s3" {
  bucket        = lower(local.s3_bucket_name)
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
  output_package_name = "lambda-test-package"
  s3_expected_key     = "deployment/${local.output_package_name}.zip"
  s3_bucket_name      = format("from-s123-bucket-%s", random_string.random_string.result)
}

/*
  * Preventive mechanism to ensure that the bucket is 'alive'
  * before the lambda function is created.
*/
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [aws_s3_bucket.s3]
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  output_path = format("%s.zip", local.output_package_name)
  source_file = "handler.js"
}

/*
  * Upload an object into the recently created test S3 bucket.
*/
resource "aws_s3_object" "upload_lambda_package" {
  source = data.archive_file.lambda_archive.output_path
  bucket = aws_s3_bucket.s3.id
  key    = local.s3_expected_key

  depends_on = [data.archive_file.lambda_archive, aws_s3_bucket.s3]
}
