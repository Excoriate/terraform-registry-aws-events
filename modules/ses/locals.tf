locals {
  aws_region_to_deploy = var.aws_region
  is_module_enabled    = !var.is_enabled ? false : var.ses_config != null

  // Normalization and mapping.
  // [1.] Core configuration
  ses_config = !local.is_module_enabled ? null : [var.ses_config]
  ses_config_normalised = !local.is_module_enabled ? {} : {
    for cfg in local.ses_config : cfg["name"] => {
      name   = trimspace(cfg["name"])
      domain = cfg["domain"] == null ? lower(trimspace(cfg["name"])) : lower(trimspace(cfg["domain"]))
  } }

  ses_config_create = !local.is_module_enabled ? {} : local.ses_config_normalised
}
