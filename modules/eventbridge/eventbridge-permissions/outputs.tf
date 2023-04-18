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
output "event_bridge_role_id" {
  value       = join("", [for role in aws_iam_role.this : role.id])
  description = "The ID of the IAM role for EventBridge."
}

output "event_bridge_role_name" {
  value       = join("", [for role in aws_iam_role.this : role.name])
  description = "The name of the IAM role for EventBridge."
}

output "event_bridge_role_arn" {
  value       = join("", [for role in aws_iam_role.this : role.arn])
  description = "The ARN of the IAM role for EventBridge."
}

output "event_bridge_policy" {
  value       = join("", [for policy in aws_iam_policy.lambda_policy : policy.arn])
  description = "The ARN of the IAM policy for EventBridge."
}

output "event_bridge_policy_doc" {
  value       = join("", [for policy in aws_iam_policy.lambda_policy : policy.policy])
  description = "The IAM policy for EventBridge."
}
