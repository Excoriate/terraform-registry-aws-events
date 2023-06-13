locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.user_pool_client_config != null

  // Specific functionalities with feature flags
  #  is_email_verification_enabled            = !local.is_module_enabled ? false : var.email_verification_config != null

  // Normalization and mapping.
  // [1.] Core user-pool-client configuration
  user_pool_client = !local.is_module_enabled ? null : var.user_pool_client_config
  user_pool_client_normalised = !local.is_module_enabled ? [] : [
    for cfg in local.user_pool_client : {
      name         = trimspace(cfg["name"])
      user_pool_id = trimspace(cfg["user_pool_id"])
  }]

  user_pool_client_create = { for cfg in local.user_pool_client_normalised : cfg["name"] => cfg }
}
