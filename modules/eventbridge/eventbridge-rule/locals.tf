locals {
  aws_region_to_deploy = var.aws_region

  /*
  - Feature flags
  -- Enable/disable the creation of the rule.
  -- Enable/disable the creation of the target.
  */

  is_module_enabled        = var.is_enabled
  is_rule_enabled          = !local.is_module_enabled ? false : var.rule_config == null ? false : length(var.rule_config) > 0
  is_event_pattern_enabled = !local.is_module_enabled ? false : !local.is_rule_enabled ? false : var.rule_event_pattern == null ? false : length(var.rule_event_pattern) > 0

  // 1. Parent event rule
  rule_cfg_normalised = !local.is_rule_enabled ? [] : [
    for rule in var.rule_config : {
      name                       = lower(trimspace(rule.name))
      description                = rule["description"] == null ? "" : trimspace(rule["description"])
      is_enabled                 = rule["is_enabled"] == null ? true : rule["is_enabled"]
      event_bus_name             = rule["event_bus_name"] == null ? "default" : trimspace(rule["event_bus_name"])
      schedule_expression        = rule["schedule_expression"] == null ? "" : trimspace(rule["schedule_expression"])
      role_arn                   = rule["role_arn"] == null ? "" : trimspace(rule["role_arn"])
      disable_default_role       = rule["disable_default_role"] == null ? false : rule["disable_default_role"] == true
      is_default_role_to_be_used = rule["disable_default_role"] == true ? false : rule["role_arn"] == null ? true : rule["role_arn"] == "" ? true : false
    }
  ]

  rule_cfg_map = !local.is_rule_enabled ? {} : {
    for rule in local.rule_cfg_normalised : rule["name"] => rule
  }

  // 2. Event pattern
  pattern_cfg_normalised = !local.is_event_pattern_enabled ? [] : [
    for pattern in var.rule_event_pattern : {
      name      = lower(trimspace(pattern.name))
      rule_name = pattern["rule_name"] == null ? lower(trimspace(pattern.name)) : lower(trimspace(pattern["rule_name"]))
      // Actual event pattern to be encoded.
      pattern_json_encoded = jsonencode({
        for key, value in {
          detail : pattern["detail"] == null ? {} : pattern["detail"]
          detail-type : pattern["detail-type"] == null ? [] : pattern["detail-type"]
          source : pattern["source"] == null ? [] : pattern["source"]
          account : pattern["account"] == null ? [] : pattern["account"]
          region : pattern["region"] == null ? [] : pattern["region"]
          resources : pattern["resources"] == null ? [] : pattern["resources"]
        } : key => value if length(value) > 0
      })
    }
  ]
  pattern_cfg_map = !local.is_event_pattern_enabled ? {} : {
    for pattern in local.pattern_cfg_normalised : pattern["name"] => pattern
  }
}
