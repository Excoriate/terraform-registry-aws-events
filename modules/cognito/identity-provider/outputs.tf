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
output "identity_provider_config" {
  value       = local.identity_provider_cfg_normalised
  description = "The user pool domain configuration"
}

output "identity_provider_id" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.id]
  description = "The identity provider id"
}

output "identity_provider_name" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.provider_name]
  description = "The identity provider name"
}

output "identity_provider_type" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.provider_type]
  description = "The identity provider type"
}

output "identity_provider_user_pool_id" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.user_pool_id]
  description = "The identity provider user pool id"
}

output "identity_provider_attribute_mapping" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.attribute_mapping]
  description = "The identity provider attribute mapping"
}

output "identity_provider_provider_details" {
  value       = [for identity_provider in aws_cognito_identity_provider.this : identity_provider.provider_details]
  description = "The identity provider provider details"
}
