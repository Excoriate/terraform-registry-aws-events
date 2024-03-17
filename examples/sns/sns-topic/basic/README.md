<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.41.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/sns/sns-topic | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | `true` | no |
| <a name="input_sns_topic_policy_custom"></a> [sns\_topic\_policy\_custom](#input\_sns\_topic\_policy\_custom) | A custom JSON-formatted policy string used to control access to the SNS topic. If not specified, a default policy<br>based on the 'topic\_publisher\_permissions' variable will be used. When specified, this policy overrides<br>any automatically generated policy, giving full control over who can publish to the SNS topic.<br><br>Note: Ensure the policy JSON is correctly formatted and valid. Incorrect policies can result in the SNS topic<br>being inaccessible or not functioning as intended. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_topic"></a> [topic](#input\_topic) | An object representing AWS SNS topics to be created, supporting both standard and FIFO topics. Each object allows you to specify:<br><br>- 'name': The name of the SNS topic, unique within an AWS account. For FIFO topics, the name must end with '.fifo'.<br>- 'display\_name' (Optional): The display name for the SNS topic, used in the "From" field for emails sent from this topic.<br>- 'policy' (Optional): A JSON-formatted string defining who can access the SNS topic.<br>- 'delivery\_policy' (Optional): A JSON-formatted string controlling how SNS retries message delivery for this topic.<br>- 'kms\_master\_key\_id' (Optional): The ID of a custom KMS key for message encryption. If not specified, AWS uses the default KMS key.<br>- 'tags' (Optional): A map of tags for resource identification and management. Defaults to an empty map.<br>- 'fifo\_topic' (Optional, Defaults to false): Specifies if the SNS topic is a FIFO topic.<br>- 'content\_based\_deduplication' (Optional, Defaults to false): Enables content-based deduplication for FIFO topics.<br><br>Example:<pre>[<br>  {<br>    name                        = "my-application-topic"<br>    display_name                = "My Application"<br>    policy                      = "{\"Version\": \"2012-10-17\",\"Statement\": [{\"Effect\": \"Allow\",\"Principal\": {\"AWS\": \"*\"},\"Action\": \"SNS:Publish\",\"Resource\": \"arn:aws:sns:us-east-1:123456789012:my-application-topic\"}]}"<br>    delivery_policy             = "{\"healthyRetryPolicy\":{\"numRetries\":10, \"numNoDelayRetries\": 0, \"minDelayTarget\": 20, \"maxDelayTarget\": 20, \"numMinDelayRetries\": 0, \"numMaxDelayRetries\": 0, \"backoffFunction\": \"linear\"}}"<br>    kms_master_key_id           = "alias/aws/sns"<br>    fifo_topic                  = false<br>    content_based_deduplication = false<br>  }<br>]</pre> | <pre>object({<br>    name                        = string<br>    display_name                = optional(string)<br>    policy                      = optional(string)<br>    delivery_policy             = optional(string)<br>    kms_master_key_id           = optional(string)<br>    fifo_topic                  = optional(bool, false)<br>    content_based_deduplication = optional(bool, false) # Relevant only if fifo_topic is true<br>  })</pre> | `null` | no |
| <a name="input_topic_publisher_permissions"></a> [topic\_publisher\_permissions](#input\_topic\_publisher\_permissions) | An object representing the permissions to publish to the SNS topic. Each object in the list allows you to specify:<br><br>- 'allowed\_services' (Optional): A list of AWS service principal names that are allowed to publish messages to the topic. For example, ['s3.amazonaws.com', 'lambda.amazonaws.com'].<br>- 'allowed\_iam\_arns' (Optional): A list of IAM role ARNs that are allowed to publish messages to the topic. For example, ['arn:aws:iam::123456789012:role/MyRole'].<br><br>Example:<pre>{<br>    allowed_services = ["s3.amazonaws.com", "lambda.amazonaws.com"]<br>    allowed_iam_arns = ["arn:aws:iam::123456789012:role/MyRole"]<br>  }</pre> | <pre>object({<br>    allowed_services = optional(list(string), [])<br>    allowed_iam_arns = optional(list(string), [])<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic. |
| <a name="output_sns_topic_display_name"></a> [sns\_topic\_display\_name](#output\_sns\_topic\_display\_name) | The display name of the SNS topic. |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | The name of the SNS topic. |
| <a name="output_sns_topic_policy"></a> [sns\_topic\_policy](#output\_sns\_topic\_policy) | The ARN of the SNS topic policy. |
| <a name="output_sns_topic_policy_doc"></a> [sns\_topic\_policy\_doc](#output\_sns\_topic\_policy\_doc) | The ARN of the SNS topic subscription. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
