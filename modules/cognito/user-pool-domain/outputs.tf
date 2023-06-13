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
output "user_pool_domain_config" {
  value       = local.domain_cfg_normalised
  description = "The user pool domain configuration"
}

output "user_pool_domain_id" {
  value       = [for user_pool in aws_cognito_user_pool_domain.this : user_pool.id]
  description = "The user pool domain id"
}

output "user_pool_domain_domain_name" {
  value       = [for user_pool in aws_cognito_user_pool_domain.this : user_pool.domain]
  description = "The user pool domain name"
}

output "user_pool_domain_certificate_arn" {
  value       = [for user_pool in aws_cognito_user_pool_domain.this : user_pool.certificate_arn]
  description = "The user pool domain certificate arn"
}
