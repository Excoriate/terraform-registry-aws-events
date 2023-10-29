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
output "ses_config" {
  value       = local.ses_config_normalised
  description = "The SES configuration passed"
}

output "ses_domain_identity" {
  value       = length(aws_ses_domain_identity.this) > 0 ? [for domain in aws_ses_domain_identity.this : domain.domain][0] : null
  description = "The SES domain identity"
}

output "ses_domain_identity_arn" {
  value       = length(aws_ses_domain_identity.this) > 0 ? [for domain in aws_ses_domain_identity.this : domain.arn][0] : null
  description = "The SES domain identity ARN"
}

output "ses_domain_identity_verification_token" {
  value       = length(aws_ses_domain_identity.this) > 0 ? [for domain in aws_ses_domain_identity.this : domain.verification_token][0] : null
  description = "The SES domain identity verification token"
}

output "ses_configuration_sets" {
  value       = length(aws_ses_configuration_set.this) > 0 ? [for configuration_set in aws_ses_configuration_set.this : configuration_set.name] : null
  description = "The SES configuration sets"
}

output "ses_identities_id" {
  value       = length(aws_ses_domain_identity.this) > 0 ? [for domain in aws_ses_domain_identity.this : domain.id] : null
  description = "The SES identities ids"
}

output "ses_mail_from_domain" {
  value       = length([for mail_from in aws_ses_domain_mail_from.this : mail_from.mail_from_domain]) > 0 ? [for mail_from in aws_ses_domain_mail_from.this : mail_from.mail_from_domain][0] : null
  description = "The SES mail from domain"
}
