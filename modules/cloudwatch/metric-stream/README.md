<!-- BEGIN_TF_DOCS -->
# ☁️ CloudWatch Metric Stream
## Description

This module provides the following capabilities:
* 🚀 **CloudWatch Metric Stream**: Streams CloudWatch metrics in near real-time to a specified destination such as Amazon S3, Amazon Redshift, or third-party service providers.
* 🔧 **Custom Setup with Kinesis Firehose**: Customize the stream to various destinations with detailed configuration options.
* 📊 **Statistics**: Stream additional statistics beyond the default ones for detailed monitoring and analysis.
* 🔄 **Cross-Account Metrics**: Optionally include metrics from linked accounts.

It supports various output formats, including JSON and OpenTelemetry. For more information about these resources, please visit the [AWS CloudWatch Metric Stream Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html), and the terraform specific documentation [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream).

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/cloudwatch/metric-stream"
  is_enabled = var.is_enabled
  tags       = var.tags
  stream     = var.stream
}
```

Simple example of a basic implementation.
```hcl
is_enabled = true

tags = {
  Environment = "Development"
  Project     = "MetricStream"
}
```

For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "cloudwatch_metric_stream_id" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.id) : ""
  description = "The ID of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_arn" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.arn) : ""
  description = "The ARN of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_name" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.name) : ""
  description = "The name of the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_firehose_arn" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.firehose_arn) : ""
  description = "The ARN of the Kinesis Firehose delivery stream used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_role_arn" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.role_arn) : ""
  description = "The ARN of the IAM role used by the CloudWatch Metric Stream."
}

output "cloudwatch_metric_stream_output_format" {
  value       = local.is_stream_enabled ? join("", aws_cloudwatch_metric_stream.this.*.output_format) : ""
  description = "The output format of the CloudWatch Metric Stream."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.41.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_statistics"></a> [additional\_statistics](#input\_additional\_statistics) | A list of additional statistics to stream for specific metrics. Each object allows you to specify:<br>- 'namespace': The namespace of the metric.<br>- 'metric\_names': A list of metric names within the namespace.<br>- 'statistics': A list of additional statistics to stream for those metrics.<br><br>Example:<pre>[<br>  {<br>    namespace    = "AWS/EC2"<br>    metric_names = ["CPUUtilization"]<br>    statistics   = ["p95", "p99"]<br>  }<br>]</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream#additional-statistics). | <pre>list(object({<br>    namespace    = string<br>    metric_names = list(string)<br>    statistics   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful for stack-composite<br>modules that conditionally include resources provided by this module. | `bool` | `true` | no |
| <a name="input_stream"></a> [stream](#input\_stream) | An object representing an AWS CloudWatch Metric Stream. Each object allows you to specify:<br><br>- 'name': The name of the metric stream, unique within an AWS account and region.<br>- 'firehose\_arn': The ARN of the Kinesis Firehose delivery stream to use for this metric stream.<br>- 'role\_arn': The ARN of the IAM role that the metric stream will use to access Firehose resources.<br>- 'output\_format': The output format for the stream. Valid values are 'json', 'opentelemetry1.0', and 'opentelemetry0.7'.<br>- 'include\_filters' (Optional, Default []): A list of namespaces and their respective metrics to include in the stream.<br>- 'exclude\_filters' (Optional, Default []): A list of namespaces and their respective metrics to exclude from the stream.<br>- 'include\_linked\_accounts\_metrics' (Optional, Default false): Whether to include metrics from source accounts linked to this monitoring account.<br>- 'statistics\_configurations' (Optional, Default []): A list of additional statistics to stream for specific metrics.<br>- 'tags' (Optional, Default {}): A map of tags to assign to the metric stream for resource management.<br><br>Example:<pre>{<br>  name                        = "my-cloudwatch-metric-stream"<br>  firehose_arn                = "arn:aws:firehose:us-west-2:123456789012:deliverystream/my-stream"<br>  role_arn                    = "arn:aws:iam::123456789012:role/my-metric-stream-role"<br>  output_format               = "json"<br>  include_filters             = [<br>    {<br>      namespace = "AWS/EC2"<br>      metrics   = ["CPUUtilization", "DiskReadOps"]<br>    }<br>  ]<br>  exclude_filters             = [<br>    {<br>      namespace = "AWS/S3"<br>      metrics   = ["BucketSizeBytes"]<br>    }<br>  ]<br>  include_linked_accounts_metrics = true<br>  statistics_configurations  = [<br>    {<br>      namespace     = "AWS/EC2"<br>      metric_names  = ["CPUUtilization"]<br>      statistics    = ["p95", "p99"]<br>    }<br>  ]<br>  tags = {<br>    Environment = "production"<br>    Project     = "metrics-stream"<br>  }<br>}</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream). | <pre>object({<br>    name          = string<br>    firehose_arn  = string<br>    role_arn      = string<br>    output_format = string<br>    include_filters = optional(list(object({<br>      namespace = string<br>      metrics   = optional(list(string), [])<br>    })), [])<br>    exclude_filters = optional(list(object({<br>      namespace = string<br>      metrics   = optional(list(string), [])<br>    })), [])<br>    include_linked_accounts_metrics = optional(bool, false)<br>    statistics_configurations = optional(list(object({<br>      namespace    = string<br>      metric_names = list(string)<br>      statistics   = list(string)<br>    })), [])<br>    tags = optional(map(string), {})<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_metric_stream_arn"></a> [cloudwatch\_metric\_stream\_arn](#output\_cloudwatch\_metric\_stream\_arn) | The ARN of the CloudWatch Metric Stream. |
| <a name="output_cloudwatch_metric_stream_firehose_arn"></a> [cloudwatch\_metric\_stream\_firehose\_arn](#output\_cloudwatch\_metric\_stream\_firehose\_arn) | The ARN of the Kinesis Firehose delivery stream used by the CloudWatch Metric Stream. |
| <a name="output_cloudwatch_metric_stream_id"></a> [cloudwatch\_metric\_stream\_id](#output\_cloudwatch\_metric\_stream\_id) | The ID of the CloudWatch Metric Stream. |
| <a name="output_cloudwatch_metric_stream_name"></a> [cloudwatch\_metric\_stream\_name](#output\_cloudwatch\_metric\_stream\_name) | The name of the CloudWatch Metric Stream. |
| <a name="output_cloudwatch_metric_stream_output_format"></a> [cloudwatch\_metric\_stream\_output\_format](#output\_cloudwatch\_metric\_stream\_output\_format) | The output format of the CloudWatch Metric Stream. |
| <a name="output_cloudwatch_metric_stream_role_arn"></a> [cloudwatch\_metric\_stream\_role\_arn](#output\_cloudwatch\_metric\_stream\_role\_arn) | The ARN of the IAM role used by the CloudWatch Metric Stream. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->