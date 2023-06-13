output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "identity_provider_config" {
  value       = module.main_module.identity_provider_config
  description = "The user pool domain configuration"
}

output "identity_provider_id" {
  value       = module.main_module.identity_provider_id
  description = "The identity provider id"
}

output "identity_provider_name" {
  value       = module.main_module.identity_provider_name
  description = "The identity provider name"
}

output "identity_provider_type" {
  value       = module.main_module.identity_provider_type
  description = "The identity provider type"
}

output "identity_provider_user_pool_id" {
  value       = module.main_module.identity_provider_user_pool_id
  description = "The identity provider user pool id"
}

output "identity_provider_attribute_mapping" {
  value       = module.main_module.identity_provider_attribute_mapping
  description = "The identity provider attribute mapping"
}

output "identity_provider_provider_details" {
  value       = module.main_module.identity_provider_provider_details
  description = "The identity provider provider details"
}
