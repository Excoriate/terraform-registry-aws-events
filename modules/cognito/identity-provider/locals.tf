locals {
  aws_region_to_deploy                      = var.aws_region
  is_module_enabled                         = !var.is_enabled ? false : var.identity_provider_config == null ? false : length(var.identity_provider_config) > 0
  is_identity_provider_optional_cfg_enabled = !var.is_enabled ? false : var.identity_provider_optionals_config == null ? false : length(var.identity_provider_optionals_config) > 0

  // Normalization and mapping.
  // [1.] Core configuration
  identity_provider_cfg = !local.is_module_enabled ? null : var.identity_provider_config
  identity_provider_cfg_normalised = !local.is_module_enabled ? [] : [
    for cfg in local.identity_provider_cfg : {
      name          = trimspace(cfg["name"])
      user_pool_id  = trimspace(cfg["user_pool_id"])
      provider_name = trimspace(cfg["provider_name"])
      provider_type = trimspace(cfg["provider_type"])
      provider_details = cfg["provider_details"] == null ? null : {
        for key, value in cfg["provider_details"] : trimspace(key) => trimspace(value)
      }
  }]

  identity_provider_cfg_create = {
    for cfg in local.identity_provider_cfg_normalised : cfg["name"] => cfg
  }

  // [2.] Optional configuration
  identity_provider_optionals_cfg = !local.is_identity_provider_optional_cfg_enabled ? null : var.identity_provider_optionals_config
  identity_provider_optionals_cfg_normalised = !local.is_identity_provider_optional_cfg_enabled ? [] : [
    for cfg in local.identity_provider_optionals_cfg : {
      name              = trimspace(cfg["name"])
      attribute_mapping = cfg["attribute_mapping"]
      idp_identifiers   = cfg["idp_identifiers"] == null ? null : [for idp in cfg["idp_identifiers"] : trimspace(idp)]
  }]

  identity_provider_optionals_cfg_create = {
    for cfg in local.identity_provider_optionals_cfg_normalised : cfg["name"] => cfg
  }
}
