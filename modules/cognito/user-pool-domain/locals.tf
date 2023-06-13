locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.user_pool_domain_config == null ? false : length(var.user_pool_domain_config) > 0

  // Normalization and mapping.
  // [1.] Core configuration
  domain = !local.is_module_enabled ? null : var.user_pool_domain_config
  domain_cfg_normalised = !local.is_module_enabled ? [] : [
    for cfg in local.domain : {
      name            = trimspace(cfg["name"])
      domain          = trimspace(cfg["domain"])
      user_pool_id    = trimspace(cfg["user_pool_id"])
      certificate_arn = cfg["certificate_arn"]
  }]

  domain_cfg_create = { for cfg in local.domain_cfg_normalised : cfg["name"] => cfg }
}
