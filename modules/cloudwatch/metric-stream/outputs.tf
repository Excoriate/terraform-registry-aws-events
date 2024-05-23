output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "sqs_queue_url" {
  value       = local.is_queue_enabled ? join("", aws_sqs_queue.this.*.url) : ""
  description = "The URL of the SQS queue."
}

output "sqs_queue_arn" {
  value       = local.is_queue_enabled ? join("", aws_sqs_queue.this.*.arn) : ""
  description = "The ARN of the SQS queue."
}

output "dlq_sqs_queue_url" {
  value       = local.is_dlq_enabled ? join("", aws_sqs_queue.dlq.*.url) : ""
  description = "The URL of the Dead Letter SQS queue."
}

output "dlq_sqs_queue_arn" {
  value       = local.is_dlq_enabled ? join("", aws_sqs_queue.dlq.*.arn) : ""
  description = "The ARN of the Dead Letter SQS queue."
}
