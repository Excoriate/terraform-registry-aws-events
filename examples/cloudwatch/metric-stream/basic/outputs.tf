output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "feature_flags" {
  value       = module.main_module.feature_flags
  description = "The feature flags for the module."
}

output "cloudwatch_metric_stream_id" {
  value       = module.main_module.cloudwatch_metric_stream_id
  description = "The ID of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_arn" {
  value       = module.main_module.cloudwatch_metric_stream_arn
  description = "The ARN of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_name" {
  value       = module.main_module.cloudwatch_metric_stream_name
  description = "The name of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_firehose_arn" {
  value       = module.main_module.cloudwatch_metric_stream_firehose_arn
  description = "The ARN of the Kinesis Firehose delivery stream used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_role_arn" {
  value       = module.main_module.cloudwatch_metric_stream_role_arn
  description = "The ARN of the IAM role used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_output_format" {
  value       = module.main_module.cloudwatch_metric_stream_output_format
  description = "The output format of the CloudWatch Metric Stream."
}
