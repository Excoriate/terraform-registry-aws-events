module "main_module" {
  source                        = "../../../../modules/lambda/lambda-function"
  is_enabled                    = var.is_enabled
  aws_region                    = var.aws_region
  lambda_config                 = var.lambda_config
  lambda_observability_config   = var.lambda_observability_config
  lambda_permissions_config     = var.lambda_permissions_config
  lambda_custom_policies_config = var.lambda_custom_policies_config
}
