output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "sns_topic_arn" {
  value       = module.main_module.sns_topic_arn
  description = "The ARN of the SNS topic."
}

output "sns_topic_name" {
  value       = module.main_module.sns_topic_name
  description = "The name of the SNS topic."
}

output "sns_topic_display_name" {
  value       = module.main_module.sns_topic_display_name
  description = "The display name of the SNS topic."
}

output "sns_topic_policy" {
  value       = module.main_module.sns_topic_policy
  description = "The ARN of the SNS topic policy."
}

output "sns_topic_policy_doc" {
  value       = module.main_module.sns_topic_policy_doc
  description = "The ARN of the SNS topic subscription."
}
