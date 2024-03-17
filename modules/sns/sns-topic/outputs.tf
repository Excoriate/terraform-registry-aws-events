output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "sns_topic_arn" {
  value       = join("", aws_sns_topic.this.*.arn)
  description = "The ARN of the SNS topic."
}

output "sns_topic_name" {
  value       = join("", aws_sns_topic.this.*.name)
  description = "The name of the SNS topic."
}

output "sns_topic_display_name" {
  value       = join("", aws_sns_topic.this.*.display_name)
  description = "The display name of the SNS topic."
}

output "sns_topic_policy" {
  value       = join("", aws_sns_topic_policy.this.*.arn)
  description = "The ARN of the SNS topic policy."
}

output "sns_topic_policy_doc" {
  value       = join("", aws_sns_topic_policy.this.*.policy)
  description = "The ARN of the SNS topic subscription."
}
