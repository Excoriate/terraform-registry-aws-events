locals {
  aws_region_to_deploy = var.aws_region

  /*
  - Feature flags
  -- Enable/disable the creation of the rule.
  -- Enable/disable the creation of the target.
  */

  is_module_enabled = var.is_enabled
  // 1. Parent event rule
}
