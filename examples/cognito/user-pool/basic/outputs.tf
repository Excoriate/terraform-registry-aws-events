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

output "user_pool_id" {
  value       = module.main_module.user_pool_id
  description = "The user pool id"
}

output "user_pool_arn" {
  value       = module.main_module.user_pool_arn
  description = "The user pool arn"
}

output "user_pool_domain" {
  value       = module.main_module.user_pool_domain
  description = "The user pool domain"
}

output "user_pool_schema" {
  value       = module.main_module.user_pool_schema
  description = "The user pool schema"
}

output "user_pool_sms_configuration" {
  value       = module.main_module.user_pool_sms_configuration
  description = "The user pool sms configuration"
}

output "user_pool_mfa_configuration" {
  value       = module.main_module.user_pool_mfa_configuration
  description = "The user pool mfa configuration"
}

output "user_pool_lambda_config" {
  value       = module.main_module.user_pool_lambda_config
  description = "The user pool lambda config"
}

output "user_pool_admin_create_user_config" {
  value       = module.main_module.user_pool_admin_create_user_config
  description = "The user pool admin create user config"
}

output "user_pool_verification_message_template" {
  value       = module.main_module.user_pool_verification_message_template
  description = "The user pool verification message template"
}

output "user_pool_email_configuration" {
  value       = module.main_module.user_pool_email_configuration
  description = "The user pool email configuration"
}

output "user_pool_password_policy" {
  value       = module.main_module.user_pool_password_policy
  description = "The user pool password policy"
}

output "user_pool_username_configuration" {
  value       = module.main_module.user_pool_username_configuration
  description = "The user pool username configuration"
}

output "user_pool_account_recovery_setting" {
  value       = module.main_module.user_pool_account_recovery_setting
  description = "The user pool account recovery setting"
}

output "user_pool_user_pool_add_ons" {
  value       = module.main_module.user_pool_user_pool_add_ons
  description = "The user pool user pool add ons"
}
