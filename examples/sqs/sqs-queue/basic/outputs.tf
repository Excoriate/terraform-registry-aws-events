output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "sqs_queue_url" {
  value       = module.main_module.sqs_queue_url
  description = "The URL of the SQS queue."
}

output "sqs_queue_arn" {
  value       = module.main_module.sqs_queue_arn
  description = "The ARN of the SQS queue."
}

output "dlq_sqs_queue_url" {
  value       = module.main_module.dlq_sqs_queue_url
  description = "The URL of the Dead Letter SQS queue."
}

output "dlq_sqs_queue_arn" {
  value       = module.main_module.dlq_sqs_queue_arn
  description = "The ARN of the Dead Letter SQS queue."
}
