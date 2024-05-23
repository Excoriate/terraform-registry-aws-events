variable "is_enabled" {
  type        = bool
  description = <<-DESC
  Whether this module will be created or not. It is useful for stack-composite
  modules that conditionally include resources provided by this module.
  DESC
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "stream" {
  type = object({
    name          = string
    firehose_arn  = string
    role_arn      = string
    output_format = string
    include_filters = optional(list(object({
      namespace = string
      metrics   = optional(list(string), [])
    })), [])
    exclude_filters = optional(list(object({
      namespace = string
      metrics   = optional(list(string), [])
    })), [])
    include_linked_accounts_metrics = optional(bool, false)
    statistics_configurations = optional(list(object({
      namespace    = string
      metric_names = list(string)
      statistics   = list(string)
    })), [])
    tags = optional(map(string), {})
  })
  description = <<-DESC
    An object representing an AWS CloudWatch Metric Stream. Each object allows you to specify:

    - 'name': The name of the metric stream, unique within an AWS account and region.
    - 'firehose_arn': The ARN of the Kinesis Firehose delivery stream to use for this metric stream.
    - 'role_arn': The ARN of the IAM role that the metric stream will use to access Firehose resources.
    - 'output_format': The output format for the stream. Valid values are 'json', 'opentelemetry1.0', and 'opentelemetry0.7'.
    - 'include_filters' (Optional, Default []): A list of namespaces and their respective metrics to include in the stream.
    - 'exclude_filters' (Optional, Default []): A list of namespaces and their respective metrics to exclude from the stream.
    - 'include_linked_accounts_metrics' (Optional, Default false): Whether to include metrics from source accounts linked to this monitoring account.
    - 'statistics_configurations' (Optional, Default []): A list of additional statistics to stream for specific metrics.
    - 'tags' (Optional, Default {}): A map of tags to assign to the metric stream for resource management.

    Example:
    ```
    {
      name                        = "my-cloudwatch-metric-stream"
      firehose_arn                = "arn:aws:firehose:us-west-2:123456789012:deliverystream/my-stream"
      role_arn                    = "arn:aws:iam::123456789012:role/my-metric-stream-role"
      output_format               = "json"
      include_filters             = [
        {
          namespace = "AWS/EC2"
          metrics   = ["CPUUtilization", "DiskReadOps"]
        }
      ]
      exclude_filters             = [
        {
          namespace = "AWS/S3"
          metrics   = ["BucketSizeBytes"]
        }
      ]
      include_linked_accounts_metrics = true
      statistics_configurations  = [
        {
          namespace     = "AWS/EC2"
          metric_names  = ["CPUUtilization"]
          statistics    = ["p95", "p99"]
        }
      ]
      tags = {
        Environment = "production"
        Project     = "metrics-stream"
      }
    }
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream).
  DESC
  default     = null

  validation {
    condition = alltrue([
      contains(["json", "opentelemetry1.0", "opentelemetry0.7"], var.stream.output_format),
      can(regex("^arn:aws:firehose:[a-z0-9-]+:\\d{12}:deliverystream/[a-zA-Z0-9_-]+$", var.stream.firehose_arn)),
      can(regex("^arn:aws:iam::\\d{12}:role/[a-zA-Z0-9+=,.@_-]+$", var.stream.role_arn)),
      length(var.stream.name) <= 255,
      length(var.stream.name) > 0
    ])
    error_message = <<-EOF
    Invalid 'stream' object. Ensure 'output_format' is one of 'json', 'opentelemetry1.0', 'opentelemetry0.7',
    'firehose_arn' and 'role_arn' are valid ARNs, and 'name' is between 1 and 255 characters.
    EOF
  }
}

variable "additional_statistics" {
  type = list(object({
    namespace    = string
    metric_names = list(string)
    statistics   = list(string)
  }))
  description = <<-DESC
    A list of additional statistics to stream for specific metrics. Each object allows you to specify:
    - 'namespace': The namespace of the metric.
    - 'metric_names': A list of metric names within the namespace.
    - 'statistics': A list of additional statistics to stream for those metrics.

    Example:
    ```
    [
      {
        namespace    = "AWS/EC2"
        metric_names = ["CPUUtilization"]
        statistics   = ["p95", "p99"]
      }
    ]
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream#additional-statistics).
  DESC
  default     = []
}
