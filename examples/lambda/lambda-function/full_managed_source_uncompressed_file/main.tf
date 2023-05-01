locals {
  output_package_name = "lambda-full-managed-existing-zip-file"
}

module "main_module" {
  source                                  = "../../../../modules/lambda/lambda-function"
  is_enabled                              = var.is_enabled
  aws_region                              = var.aws_region
  lambda_config                           = var.lambda_config
  lambda_archive_config                   = var.lambda_archive_config
  lambda_observability_config             = var.lambda_observability_config
  lambda_image_config                     = var.lambda_image_config
  lambda_permissions_config               = var.lambda_permissions_config
  lambda_custom_policies_config           = var.lambda_custom_policies_config
  lambda_enable_eventbridge               = var.lambda_enable_eventbridge
  lambda_enable_secrets_manager           = var.lambda_enable_secrets_manager
  lambda_host_config                      = var.lambda_host_config
  lambda_network_config                   = var.lambda_network_config
  lambda_alias_config                     = var.lambda_alias_config
  lambda_s3_from_existing_config          = var.lambda_s3_from_existing_config
  lambda_s3_from_existing_new_file_config = var.lambda_s3_from_existing_new_file_config
  lambda_full_managed_config = [
    {
      name               = "lambda-full-managed-uncompressed-file"
      compress_from_file = "handler.js"
    }
  ]
}
