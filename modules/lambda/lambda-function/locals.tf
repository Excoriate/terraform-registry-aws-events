locals {
  aws_region_to_deploy                 = var.aws_region
  is_module_enabled                    = !var.is_enabled ? false : var.lambda_config == null ? false : length(var.lambda_config) > 0
  is_observability_enabled             = !local.is_module_enabled ? false : var.lambda_observability_config == null ? false : length(var.lambda_observability_config) > 0
  is_permissions_enabled               = !local.is_module_enabled ? false : var.lambda_permissions_config == null ? false : length(var.lambda_permissions_config) > 0
  is_lambda_custom_policy_arns_enabled = !local.is_module_enabled ? false : var.lambda_custom_policies_config == null ? false : length(var.lambda_custom_policies_config) > 0

  /*
    * -------------------------------
    * Observability configuration.
    * -------------------------------
  */
  observability_normalised = !local.is_observability_enabled ? [] : [
    for config in var.lambda_observability_config : {
      name                   = trimspace(lower(config.name))
      log_group_name         = format("%s-logs", config.name)
      logs_retention_in_days = config["logs_retention_in_days"] == null ? 0 : config["logs_retention_in_days"]
      is_enabled             = config["logs_enabled"] == null ? true : config["logs_enabled"]
    }
  ]

  observability_cfg = !local.is_observability_enabled ? {} : {
    for config in local.observability_normalised : config["name"] => config
  }

  /*
    * -------------------------------
    * Permissions configuration
    * 1. Main role creation.
    * -------------------------------
  */
  permissions_normalised = !local.is_permissions_enabled ? [] : [
    for p in var.lambda_permissions_config : {
      name                  = trimspace(lower(p.name))
      permissions_boundary  = p["permissions_boundary"] == null ? null : p["permissions_boundary"]
      force_detach_policies = true
      trusted_entities = p["trusted_principals"] == null ? [] : [
        for tp in p["trusted_principals"] : {
          type        = tp["type"] == null ? "AWS" : tp["type"]
          identifiers = tp["identifiers"] == null ? [] : tp["identifiers"]
        }
      ]
    }
  ]

  permissions_cfg = !local.is_permissions_enabled ? {} : {
    for p in local.permissions_normalised : p["name"] => p
  }

  /*
    * -------------------------------
    * Permissions configuration
    * 2. Attach custom policy arns, if they are passed
    * -------------------------------
  */
  custom_policies_cfg = !local.is_lambda_custom_policy_arns_enabled ? [] : flatten([
    for role_config in var.lambda_custom_policies_config : [
      for policy_arn in role_config["policy_arns"] : {
        name       = trimspace(lower(role_config["name"]))
        policy_arn = policy_arn
      }
    ]
  ])
}
