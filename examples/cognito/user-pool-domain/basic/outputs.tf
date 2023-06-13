output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "user_pool_domain_config" {
  value       = module.main_module.user_pool_domain_config
  description = "The user pool domain configuration"
}

output "user_pool_domain_id" {
  value       = module.main_module.user_pool_domain_id
  description = "The user pool domain id"
}

output "user_pool_domain_domain_name" {
  value       = module.main_module.user_pool_domain_domain_name
  description = "The user pool domain name"
}

output "user_pool_domain_certificate_arn" {
  value       = module.main_module.user_pool_domain_certificate_arn
  description = "The user pool domain certificate arn"
}
