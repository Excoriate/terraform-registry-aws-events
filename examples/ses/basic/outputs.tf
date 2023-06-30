output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "ses_config" {
  value       = module.main_module.ses_config
  description = "The SES configuration passed"
}

output "ses_domain_identity" {
  value       = module.main_module.ses_domain_identity
  description = "The SES domain identity"
}

output "ses_domain_identity_arn" {
  value       = module.main_module.ses_domain_identity_arn
  description = "The SES domain identity ARN"
}

output "ses_domain_identity_verification_token" {
  value       = module.main_module.ses_domain_identity_verification_token
  description = "The SES domain identity verification token"
}

output "ses_configuration_sets" {
  value       = module.main_module.ses_configuration_sets
  description = "The SES configuration sets"
}

output "ses_identities_id" {
  value       = module.main_module.ses_identities_id
  description = "The SES identities ids"
}

output "ses_mail_from_domain" {
  value       = module.main_module.ses_mail_from_domain
  description = "The SES mail from domain"
}
