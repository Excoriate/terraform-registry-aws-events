locals {
  aws_region_to_deploy           = var.aws_region
  is_module_enabled              = !var.is_enabled ? false : var.ses_config != null
  is_verification_config_enabled = !var.is_enabled ? false : var.ses_verification_config != null

  // Normalization and mapping.
  // [1.] Core configuration
  ses_config = !local.is_module_enabled ? null : [var.ses_config]
  ses_config_normalised = !local.is_module_enabled ? {} : {
    for cfg in local.ses_config : cfg["name"] => {
      name   = trimspace(cfg["name"])
      domain = cfg["domain"] == null ? lower(trimspace(cfg["name"])) : lower(trimspace(cfg["domain"]))
  } }

  ses_config_create = !local.is_module_enabled ? {} : local.ses_config_normalised

  // [2.] Verification configuration
  ses_verification_config = !local.is_verification_config_enabled ? null : [var.ses_verification_config]
  ses_verification_config_normalised = !local.is_verification_config_enabled ? {} : {
    for cfg in local.ses_verification_config : cfg["name"] => {
      name    = trimspace(cfg["name"])
      domain  = lookup(local.ses_config_create[trimspace(cfg["name"])], "domain") // optimistically lookup the domain name from the core configuration.
      enabled = cfg["enabled"] == null ? false : cfg["enabled"]
      ttl     = cfg["ttl"] == null ? 600 : cfg["ttl"]
  } if cfg["enabled"] } // This functionality can be enabled/disabled per domain.

  ses_verification_config_create = !local.is_verification_config_enabled ? {} : local.ses_verification_config_normalised
}
