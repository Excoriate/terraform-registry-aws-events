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

output "ses_domain_identity_record" {
  value       = module.main_module.ses_domain_identity_record
  description = "The SES domain identity verification record"
}

output "ses_domain_identity_record_name" {
  value       = module.main_module.ses_domain_identity_record_name
  description = "The SES domain identity verification record name"
}

output "ses_domain_identity_record_type" {
  value       = module.main_module.ses_domain_identity_record_type
  description = "The SES domain identity verification record type"
}
