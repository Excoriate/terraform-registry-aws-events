locals {
  aws_region_to_deploy    = var.aws_region
  is_enabled              = !var.is_enabled ? false : var.task_config == null ? false : length(var.task_config) > 0 ? true : false
}
