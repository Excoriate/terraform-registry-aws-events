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
output "event_rule_id" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.id]
  description = "The ID of the CloudWatch Event Rule."
}

output "event_rule_arn" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.arn]
  description = "The ARN of the CloudWatch Event Rule."
}

output "event_rule_name" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.name]
  description = "The name of the CloudWatch Event Rule."
}

output "event_rule_description" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.description]
  description = "The description of the CloudWatch Event Rule."
}

output "event_rule_event_pattern" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.event_pattern]
  description = "The event pattern of the CloudWatch Event Rule."
}

output "event_rule_iam_role_id" {
  value       = [for a in aws_iam_role.this : a.id]
  description = "The IAM role ARN of the CloudWatch Event Rule."
}

output "event_rule_iam_role_arn" {
  value       = [for a in aws_iam_role.this : a.arn]
  description = "The IAM role ARN of the CloudWatch Event Rule."
}

output "event_rule_iam_role_name" {
  value       = [for a in aws_iam_role.this : a.name]
  description = "The IAM role name of the CloudWatch Event Rule."
}
