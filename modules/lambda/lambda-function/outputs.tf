output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "lambda_config_resolved" {
  value = {
    lambda_cfg       = local.lambda_cfg
    archive_cfg      = local.archive_cfg
    full_managed_cfg = local.full_managed_cfg
  }
  description = "The resolved lambda configuration."
}
