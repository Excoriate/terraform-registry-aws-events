output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "user_pool_configuration" {
  value       = module.main_module.user_pool_configuration
  description = "The user pool configuration"
}
