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
output "user_pool_client_configuration" {
  value       = local.user_pool_client_create
  description = "The user pool client configuration"
}

output "user_pool_client_id" {
  value       = [for user_pool in aws_cognito_user_pool_client.this : user_pool.id]
  description = "The user pool client id"
}

output "user_pool_client_secret" {
  value       = [for user_pool in aws_cognito_user_pool_client.this : user_pool.client_secret]
  description = "The user pool client secret"
  sensitive   = true
}
