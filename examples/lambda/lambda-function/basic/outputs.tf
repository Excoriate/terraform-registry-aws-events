output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "lambda_config_resolved" {
  value       = module.main_module.lambda_config_resolved
  description = "The resolved lambda configuration."
}
