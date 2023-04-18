module "main_module" {
  source                    = "../../../../modules/eventbridge/eventbridge-permissions"
  is_enabled                = var.is_enabled
  aws_region                = var.aws_region
  role_config               = var.role_config
  lambda_permissions_config = var.lambda_permissions_config
  attach_policies           = var.attach_policies
}
