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

### Recipe 1: Basic

```hcl
module "main_module" {
  source     = "../../../../modules/cloudwatch/metric-stream"
  is_enabled = var.is_enabled
  tags       = var.tags
  stream = {
    name          = "metric-stream-basic"
    firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
    role_arn      = aws_iam_role.metric_stream_to_firehose.arn
    output_format = "json"
  }
  statistics_configurations = var.statistics_configurations
  include_filters           = var.include_filters
  exclude_filters           = var.exclude_filters
}

data "aws_iam_policy_document" "streams_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "metric_stream_to_firehose" {
  name               = "metric_stream_to_firehose_role_basic"
  assume_role_policy = data.aws_iam_policy_document.streams_assume_role.json
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
data "aws_iam_policy_document" "metric_stream_to_firehose" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.s3_stream.arn]
  }
}
resource "aws_iam_role_policy" "metric_stream_to_firehose" {
  name   = "metric_stream_firehose_${random_id.bucket_suffix.hex}"
  role   = aws_iam_role.metric_stream_to_firehose.id
  policy = data.aws_iam_policy_document.metric_stream_to_firehose.json
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "metric-stream-test-bucket-${random_id.bucket_suffix.hex}"
}

data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "firehose_to_s3" {
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

data "aws_iam_policy_document" "firehose_to_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose_to_s3" {
  name   = "firehose_to_s3_pol_${random_id.bucket_suffix.hex}"
  role   = aws_iam_role.firehose_to_s3.id
  policy = data.aws_iam_policy_document.firehose_to_s3.json
}

resource "aws_kinesis_firehose_delivery_stream" "s3_stream" {
  name        = "metric-stream-test-stream-${random_id.bucket_suffix.hex}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_to_s3.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}
```
### Advanced Example: Custom Setup with Kinesis Firehose

```hcl
module "main_module" {
  source     = "../../../../modules/cloudwatch/metric-stream"
  is_enabled = var.is_enabled
  tags       = var.tags
  stream = {
    name          = "metric-stream-advanced"
    firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
    role_arn      = aws_iam_role.metric_stream_to_firehose.arn
    output_format = "json"
  }
  statistics_configurations = [
    {
      namespace             = "AWS/EC2"
      metric_name           = "CPUUtilization"
      additional_statistics = ["p95", "p99"]
      include_metrics = [
        {
          metric_name = "DiskReadOps"
          namespace   = "AWS/EC2"
        },
        {
          metric_name = "DiskWriteOps"
          namespace   = "AWS/EC2"
        }
      ]
    },
    {
      namespace             = "AWS/RDS"
      metric_name           = "CPUUtilization"
      additional_statistics = ["p90", "p99"]
      include_metrics = [
        {
          metric_name = "ReadIOPS"
          namespace   = "AWS/RDS"
        },
        {
          metric_name = "WriteIOPS"
          namespace   = "AWS/RDS"
        }
      ]
    }
  ]
  include_filters = [
    {
      namespace    = "AWS/EC2"
      metric_names = ["CPUUtilization", "DiskReadOps", "DiskWriteOps"]
    },
    {
      namespace    = "AWS/RDS"
      metric_names = ["CPUUtilization", "ReadIOPS", "WriteIOPS"]
    }
  ]
  #   exclude_filters = [
  #     {
  #       namespace    = "AWS/S3"
  #       metric_names = ["BucketSizeBytes", "NumberOfObjects"]
  #     },
  #     {
  #       namespace    = "AWS/ELB"
  #       metric_names = ["HealthyHostCount", "UnHealthyHostCount"]
  #     }
  #   ]
}

data "aws_iam_policy_document" "streams_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "metric_stream_to_firehose" {
  name               = "metric_stream_firehose_${random_id.bucket_suffix.hex}"
  assume_role_policy = data.aws_iam_policy_document.streams_assume_role.json
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
data "aws_iam_policy_document" "metric_stream_to_firehose" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.s3_stream.arn]
  }
}
resource "aws_iam_role_policy" "metric_stream_to_firehose" {
  name   = "metric_stream_to_firehose_policy_advanced"
  role   = aws_iam_role.metric_stream_to_firehose.id
  policy = data.aws_iam_policy_document.metric_stream_to_firehose.json
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "metric-stream-test-bucket-${random_id.bucket_suffix.hex}"
}

data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "firehose_to_s3" {
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

data "aws_iam_policy_document" "firehose_to_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose_to_s3" {
  name   = "firehose_to_s3_policy_advanced"
  role   = aws_iam_role.firehose_to_s3.id
  policy = data.aws_iam_policy_document.firehose_to_s3.json
}

resource "aws_kinesis_firehose_delivery_stream" "s3_stream" {
  name        = "metric-stream-test-stream-${random_id.bucket_suffix.hex}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_to_s3.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |

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
| <a name="input_exclude_filters"></a> [exclude\_filters](#input\_exclude\_filters) | A list of namespaces and their respective metrics to exclude from the CloudWatch Metric Stream.<br>Each object allows you to specify:<br>- 'namespace': The namespace of the metrics.<br>- 'metric\_names': A list of metric names within the namespace.<br><br>Example:<pre>[<br>  {<br>    namespace = "AWS/S3"<br>    metrics   = ["BucketSizeBytes"]<br>  }<br>]</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream). | <pre>list(object({<br>    namespace    = string<br>    metric_names = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_include_filters"></a> [include\_filters](#input\_include\_filters) | A list of namespaces and their respective metrics to include in the CloudWatch Metric Stream.<br>Each object allows you to specify:<br>- 'namespace': The namespace of the metrics.<br>- 'metrics': A list of metric names within the namespace.<br><br>Example:<pre>[<br>  {<br>    namespace = "AWS/EC2"<br>    metric_names   = ["CPUUtilization", "DiskReadOps"]<br>  }<br>]</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream). | <pre>list(object({<br>    namespace    = string<br>    metric_names = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful for stack-composite<br>modules that conditionally include resources provided by this module. | `bool` | `true` | no |
| <a name="input_statistics_configurations"></a> [statistics\_configurations](#input\_statistics\_configurations) | A list of statistics configurations for specific metrics. Each object allows you to specify:<br>- 'namespace': The namespace of the metric.<br>- 'metric\_name': The name of the metric within the namespace.<br>- 'additional\_statistics': A list of additional statistics to stream for those metrics.<br>- 'include\_metrics' (Optional, Default []): A list of additional metrics to include in the configuration.<br><br>Example:<pre>[<br>  {<br>    namespace             = "AWS/EC2"<br>    metric_name           = "CPUUtilization"<br>    additional_statistics = ["p1", "tm99"]<br>    include_metrics       = [<br>      {<br>        metric_name = "DiskReadOps"<br>        namespace   = "AWS/EC2"<br>      }<br>    ]<br>  }<br>]</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream#statistics_configuration). | <pre>list(object({<br>    namespace             = string<br>    metric_name           = string<br>    additional_statistics = list(string)<br>    include_metrics = optional(list(object({<br>      metric_name = string<br>      namespace   = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_stream"></a> [stream](#input\_stream) | An object representing an AWS CloudWatch Metric Stream. Each object allows you to specify:<br><br>- 'name': The name of the metric stream, unique within an AWS account and region.<br>- 'firehose\_arn': The ARN of the Kinesis Firehose delivery stream to use for this metric stream.<br>- 'role\_arn': The ARN of the IAM role that the metric stream will use to access Firehose resources.<br>- 'output\_format': The output format for the stream. Valid values are 'json', 'opentelemetry1.0', and 'opentelemetry0.7'.<br>- 'include\_linked\_accounts\_metrics' (Optional, Default false): Whether to include metrics from source accounts linked to this monitoring account.<br>- 'tags' (Optional, Default {}): A map of tags to assign to the metric stream for resource management.<br><br>Example:<pre>{<br>  name                        = "my-cloudwatch-metric-stream"<br>  firehose_arn                = "arn:aws:firehose:us-west-2:123456789012:deliverystream/my-stream"<br>  role_arn                    = "arn:aws:iam::123456789012:role/my-metric-stream-role"<br>  output_format               = "json"<br>  include_linked_accounts_metrics = true<br>}</pre>For more details, see the [AWS CloudWatch Metric Stream documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream). | <pre>object({<br>    name                            = string<br>    firehose_arn                    = string<br>    role_arn                        = string<br>    output_format                   = string<br>    include_linked_accounts_metrics = optional(bool, false)<br>  })</pre> | `null` | no |
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
| <a name="output_feature_flags"></a> [feature\_flags](#output\_feature\_flags) | The feature flags for the module. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
