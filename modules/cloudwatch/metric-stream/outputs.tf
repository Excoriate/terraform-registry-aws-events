output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "feature_flags" {
  value = {
    is_stream_enabled                   = local.is_stream_enabled
    is_statistics_configuration_enabled = local.is_statistics_configuration_enabled
    is_include_filters_enabled          = local.is_include_filters_enabled
    is_exclude_filters_enabled          = local.is_exclude_filters_enabled
  }
  description = "The feature flags for the module."
}

output "cloudwatch_metric_stream_id" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.id])
  description = "The ID of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_arn" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.arn])
  description = "The ARN of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_name" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.name])
  description = "The name of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_firehose_arn" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.firehose_arn])
  description = "The ARN of the Kinesis Firehose delivery stream used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_role_arn" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.role_arn])
  description = "The ARN of the IAM role used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_output_format" {
  value       = !local.is_stream_enabled ? "" : join("", [for stream in aws_cloudwatch_metric_stream.this : stream.output_format])
  description = "The output format of the CloudWatch Metric Stream."
}
