output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "user_pool_client_configuration" {
  value       = module.main_module.user_pool_client_configuration
  description = "The user pool client configuration"
}

output "user_pool_client_id" {
  value       = module.main_module.user_pool_client_id
  description = "The user pool client id"
}

output "user_pool_client_secret" {
  value       = module.main_module.user_pool_client_secret
  description = "The user pool client secret"
  sensitive   = true

}
