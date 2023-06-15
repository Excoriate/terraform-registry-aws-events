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
  value       = [for domain in aws_ses_domain_identity.this : domain.domain][0]
  description = "The SES domain identity"
}

output "ses_domain_identity_arn" {
  value       = [for domain in aws_ses_domain_identity.this : domain.arn][0]
  description = "The SES domain identity ARN"
}

output "ses_domain_identity_verification_token" {
  value       = [for domain in aws_ses_domain_identity.this : domain.verification_token][0]
  description = "The SES domain identity verification token"
}
