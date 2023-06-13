locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.user_pool_client_config == null ? false : length(var.user_pool_client_config) > 0

  // Specific functionalities with feature flags
  is_oauth_enabled = !local.is_module_enabled ? false : var.oauth_config == null ? false : length(var.oauth_config) > 0

  // Normalization and mapping.
  // [1.] Core user-pool-client configuration
  user_pool_client = !local.is_module_enabled ? null : var.user_pool_client_config
  user_pool_client_normalised = !local.is_module_enabled ? [] : [
    for cfg in local.user_pool_client : {
      name         = trimspace(cfg["name"])
      user_pool_id = trimspace(cfg["user_pool_id"])
  }]

  user_pool_client_create = { for cfg in local.user_pool_client_normalised : cfg["name"] => cfg }

  // [2.] OAuth configuration
  oauth_config = !local.is_oauth_enabled ? null : var.oauth_config
  oauth_config_normalised = !local.is_oauth_enabled ? [] : [
    for cfg in local.oauth_config : {
      name                                 = trimspace(cfg["name"])
      allowed_oauth_flows                  = cfg["allowed_oauth_flows"]
      allowed_oauth_scopes                 = cfg["allowed_oauth_scopes"]
      allowed_oauth_flows_user_pool_client = cfg["allowed_oauth_flows_user_pool_client"] == null ? false : cfg["allowed_oauth_flows_user_pool_client"]
      callback_urls                        = cfg["callback_urls"] == null ? null : [for url in cfg["callback_urls"] : trimspace(url)]
  }]

  oauth_config_create = { for cfg in local.oauth_config_normalised : cfg["name"] => cfg }
}
