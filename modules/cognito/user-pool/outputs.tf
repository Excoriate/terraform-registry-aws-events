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
output "user_pool_configuration" {
  value       = local.user_pool_config
  description = "The user pool configuration"
}

output "user_pool_id" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.id][0]
  description = "The user pool id"
}

output "user_pool_arn" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.arn][0]
  description = "The user pool arn"
}

output "user_pool_domain" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.domain][0]
  description = "The user pool domain"
}

output "user_pool_schema" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.schema][0]
  description = "The user pool schema"
}

output "user_pool_sms_configuration" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.sms_configuration][0]
  description = "The user pool sms configuration"
}

output "user_pool_mfa_configuration" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.mfa_configuration][0]
  description = "The user pool mfa configuration"
}

output "user_pool_lambda_config" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.lambda_config][0]
  description = "The user pool lambda config"
}

output "user_pool_admin_create_user_config" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.admin_create_user_config][0]
  description = "The user pool admin create user config"
}

output "user_pool_verification_message_template" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.verification_message_template][0]
  description = "The user pool verification message template"
}

output "user_pool_email_configuration" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.email_configuration][0]
  description = "The user pool email configuration"
}

output "user_pool_password_policy" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.password_policy][0]
  description = "The user pool password policy"
}

output "user_pool_username_configuration" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.username_configuration][0]
  description = "The user pool username configuration"
}

output "user_pool_account_recovery_setting" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.account_recovery_setting][0]
  description = "The user pool account recovery setting"
}

output "user_pool_user_pool_add_ons" {
  value       = [for user_pool in aws_cognito_user_pool.this : user_pool.user_pool_add_ons][0]
  description = "The user pool user pool add ons"
}
