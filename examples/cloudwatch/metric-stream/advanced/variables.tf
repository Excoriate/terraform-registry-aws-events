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

variable "statistics_configurations" {
  type = list(object({
    namespace             = string
    metric_name           = string
    additional_statistics = list(string)
    include_metrics = optional(list(object({
      metric_name = string
      namespace   = string
    })), [])
  }))
  description = <<-DESC
    A list of statistics configurations for specific metrics. Each object allows you to specify:
    - 'namespace': The namespace of the metric.
    - 'metric_name': The name of the metric within the namespace.
    - 'additional_statistics': A list of additional statistics to stream for those metrics.
    - 'include_metrics' (Optional, Default []): A list of additional metrics to include in the configuration.

    Example:
    ```
    [
      {
        namespace             = "AWS/EC2"
        metric_name           = "CPUUtilization"
        additional_statistics = ["p1", "tm99"]
        include_metrics       = [
          {
            metric_name = "DiskReadOps"
            namespace   = "AWS/EC2"
          }
        ]
      }
    ]
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream#statistics_configuration).
  DESC
  default     = []
}

variable "stream" {
  type = object({
    name                            = string
    firehose_arn                    = string
    role_arn                        = string
    output_format                   = string
    include_linked_accounts_metrics = optional(bool, false)
  })
  description = <<-DESC
    An object representing an AWS CloudWatch Metric Stream. Each object allows you to specify:

    - 'name': The name of the metric stream, unique within an AWS account and region.
    - 'firehose_arn': The ARN of the Kinesis Firehose delivery stream to use for this metric stream.
    - 'role_arn': The ARN of the IAM role that the metric stream will use to access Firehose resources.
    - 'output_format': The output format for the stream. Valid values are 'json', 'opentelemetry1.0', and 'opentelemetry0.7'.
    - 'include_linked_accounts_metrics' (Optional, Default false): Whether to include metrics from source accounts linked to this monitoring account.
    - 'tags' (Optional, Default {}): A map of tags to assign to the metric stream for resource management.

    Example:
    ```
    {
      name                        = "my-cloudwatch-metric-stream"
      firehose_arn                = "arn:aws:firehose:us-west-2:123456789012:deliverystream/my-stream"
      role_arn                    = "arn:aws:iam::123456789012:role/my-metric-stream-role"
      output_format               = "json"
      include_linked_accounts_metrics = true
    }
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream).
  DESC
  default     = null
}

variable "include_filters" {
  type = list(object({
    namespace    = string
    metric_names = optional(list(string), [])
  }))
  description = <<-DESC
    A list of namespaces and their respective metrics to include in the CloudWatch Metric Stream.
    Each object allows you to specify:
    - 'namespace': The namespace of the metrics.
    - 'metrics': A list of metric names within the namespace.

    Example:
    ```
    [
      {
        namespace = "AWS/EC2"
        metric_names   = ["CPUUtilization", "DiskReadOps"]
      }
    ]
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream).
  DESC
  default     = null
}

variable "exclude_filters" {
  type = list(object({
    namespace    = string
    metric_names = optional(list(string), [])
  }))
  description = <<-DESC
    A list of namespaces and their respective metrics to exclude from the CloudWatch Metric Stream.
    Each object allows you to specify:
    - 'namespace': The namespace of the metrics.
    - 'metric_names': A list of metric names within the namespace.

    Example:
    ```
    [
      {
        namespace = "AWS/S3"
        metrics   = ["BucketSizeBytes"]
      }
    ]
    ```

    For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream).
  DESC
  default     = null
}
