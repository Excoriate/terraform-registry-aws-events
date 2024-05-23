<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.41.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/cloudwatch/metric-stream | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.firehose_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.metric_stream_to_firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.firehose_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.metric_stream_to_firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.s3_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/3.6.2/docs/resources/id) | resource |
| [aws_iam_policy_document.firehose_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.metric_stream_to_firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.streams_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful for stack-composite<br>modules that conditionally include resources provided by this module. | `bool` | `true` | no |
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