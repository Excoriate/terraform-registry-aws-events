<!-- BEGIN_TF_DOCS -->
# ☁️ SQS queue
## Description

This module creates an event bridge rule, with the following capabilities:
* 🚀 **Event bridge rule**: Event bridge rule with the specified name.
* 🚀 **Event pattern**: Event pattern to filter the events that will trigger the rule.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source            = "../../../../modules/sqs/sqs-queue"
  is_enabled        = var.is_enabled
  queue             = var.queue
  dead_letter_queue = var.dead_letter_queue
  queue_policies    = var.queue_policies
  tags              = var.tags
}
```

Simple example of a basic implementation.
```hcl
is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "test-queue"
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 10240 # 10 KB
  delay_seconds                     = 5
  receive_wait_time_seconds         = 10
  fifo_queue                        = false
  content_based_deduplication       = false
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 86400 # 24 hours
  #  deduplication_scope               = "queue"
  #  fifo_throughput_limit = "perQueue"
}
```

Example where multiple event rules are created at once.
```hcl
is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "my-application-queue"
  fifo_queue                        = true
  content_based_deduplication       = true
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 2048  # 2 KB
  delay_seconds                     = 10
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 600 # 10 minutes
}

dead_letter_queue = {
  name                              = "my-application-queue-dlq"
  fifo_queue                        = true
  content_based_deduplication       = true
  max_receive_count                 = 3
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 2048  # 2 KB
  delay_seconds                     = 10
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 600 # 10 minutes
}
```

Example where an event pattern is passed.
```hcl
is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "test-queue" # Name must end with '.fifo' for FIFO queues
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 10240 # 10 KB
  delay_seconds                     = 5
  receive_wait_time_seconds         = 10
  fifo_queue                        = true # Must be true for FIFO queues
  content_based_deduplication       = true # Enable or disable based on your use case
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 86400               # 24 hours
  deduplication_scope               = "messageGroup"      # FIFO queues support 'messageGroup' or 'queue' as valid values
  fifo_throughput_limit             = "perMessageGroupId" # 'perQueue' or 'perMessageGroupId' are valid
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.41.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dead_letter_queue"></a> [dead\_letter\_queue](#input\_dead\_letter\_queue) | An optional object representing an AWS SQS dead letter queue to be created alongside the main SQS queue.<br>Specify only if you want to create a dead letter queue. Each object allows you to specify:<br><br>- 'name' (Optional): The name of the SQS dead letter queue. If not provided, a name is generated based on the main queue's name with a '-dlq' suffix.<br>- 'max\_receive\_count' (Optional, Default 5): The number of times a message is delivered to the source queue before being moved to the dead letter queue.<br>- 'visibility\_timeout\_seconds', 'message\_retention\_seconds', 'max\_message\_size', 'delay\_seconds', 'receive\_wait\_time\_seconds', 'policy', 'fifo\_queue', 'content\_based\_deduplication', 'kms\_master\_key\_id', 'kms\_data\_key\_reuse\_period\_seconds', 'deduplication\_scope', 'fifo\_throughput\_limit': Configurations for the dead letter queue, with defaults where applicable.<br><br>Example:<pre>{<br>  name                              = "my-application-queue-dlq.fifo"<br>  fifo_queue                        = true<br>  content_based_deduplication       = true<br>  max_receive_count                 = 3<br>  visibility_timeout_seconds        = 45<br>  message_retention_seconds         = 86400<br>  max_message_size                  = 2048<br>  delay_seconds                     = 10<br>  receive_wait_time_seconds         = 20<br>  kms_master_key_id                 = "alias/aws/sqs"<br>  kms_data_key_reuse_period_seconds = 600<br>}</pre> | <pre>object({<br>    name                              = optional(string)<br>    max_receive_count                 = optional(number, 5)<br>    visibility_timeout_seconds        = optional(number, 30)<br>    message_retention_seconds         = optional(number, 345600)<br>    max_message_size                  = optional(number, 262144)<br>    delay_seconds                     = optional(number, 0)<br>    receive_wait_time_seconds         = optional(number, 0)<br>    policy                            = optional(string)<br>    fifo_queue                        = optional(bool, false)<br>    content_based_deduplication       = optional(bool, false) # Relevant only if fifo_queue is true<br>    kms_master_key_id                 = optional(string)<br>    kms_data_key_reuse_period_seconds = optional(number, 300)<br>    deduplication_scope               = optional(string, null) # Valid values are "queue" and "messageGroup"<br>    fifo_throughput_limit             = optional(string, null) # Valid values are "perQueue" and "perMessageGroupId"<br>  })</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | `true` | no |
| <a name="input_queue"></a> [queue](#input\_queue) | An object representing an AWS SQS queue to be created, supporting both standard and FIFO queues. Each object allows you to specify:<br><br>- 'name': The name of the SQS queue, unique within an AWS account. For FIFO queues, the name must end with '.fifo'.<br>- 'visibility\_timeout\_seconds' (Optional, Default 30): The visibility timeout for the queue. An integer from 0 to 43200 (12 hours).<br>- 'message\_retention\_seconds' (Optional, Default 345600): The number of seconds SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days).<br>- 'max\_message\_size' (Optional, Default 262144): The limit of how many bytes a message can contain before SQS rejects it. From 1024 bytes (1 KiB) to 262144 bytes (256 KiB).<br>- 'delay\_seconds' (Optional, Default 0): The queue's default delay for messages in seconds. An integer from 0 to 900 (15 minutes).<br>- 'receive\_wait\_time\_seconds' (Optional, Default 0): The duration (in seconds) for which the call waits for a message to arrive in the queue before returning.<br>- 'policy' (Optional): The JSON policy for the queue.<br>- 'redrive\_policy' (Optional): The JSON policy to specify the dead-letter queue for this SQS queue.<br>- 'fifo\_queue' (Optional, Defaults to false): Specifies if the SQS queue is a FIFO queue.<br>- 'content\_based\_deduplication' (Optional, Defaults to false): Enables content-based deduplication for FIFO queues.<br>- 'kms\_master\_key\_id' (Optional): The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK.<br>- 'kms\_data\_key\_reuse\_period\_seconds' (Optional, Default 300): The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling KMS again.<br>- 'tags' (Optional, Defaults to an empty map): A map of tags to assign to the queue for resource management.<br>- 'deduplication\_scope' (Optional, Default "queue"): Specifies the deduplication scope. Valid values are "queue" and "messageGroup".<br>- 'fifo\_throughput\_limit' (Optional, Default "perQueue"): Specifies the throughput limit. Valid values are "perQueue" and "perMessageGroupId".<br><br>Example:<pre>{<br>  name                              = "my-application-queue.fifo"<br>  fifo_queue                        = true<br>  content_based_deduplication       = true<br>  visibility_timeout_seconds        = 45<br>  message_retention_seconds         = 86400<br>  max_message_size                  = 2048<br>  delay_seconds                     = 10<br>  receive_wait_time_seconds         = 20<br>  kms_master_key_id                 = "alias/aws/sqs"<br>  kms_data_key_reuse_period_seconds = 600<br>}</pre> | <pre>object({<br>    name                              = string<br>    visibility_timeout_seconds        = optional(number, 30)<br>    message_retention_seconds         = optional(number, 345600)<br>    max_message_size                  = optional(number, 262144)<br>    delay_seconds                     = optional(number, 0)<br>    receive_wait_time_seconds         = optional(number, 0)<br>    policy                            = optional(string)<br>    redrive_policy                    = optional(string)<br>    fifo_queue                        = optional(bool, false)<br>    content_based_deduplication       = optional(bool, false) # Relevant only if fifo_queue is true<br>    kms_master_key_id                 = optional(string)<br>    kms_data_key_reuse_period_seconds = optional(number, 300)<br>    deduplication_scope               = optional(string, null) # Valid values are "queue" and "messageGroup"<br>    fifo_throughput_limit             = optional(string, null) # Valid values are "perQueue" and "perMessageGroupId"<br>  })</pre> | `null` | no |
| <a name="input_queue_policies"></a> [queue\_policies](#input\_queue\_policies) | A list of policy objects to apply to the SQS queues. Each policy allows you to specify<br>actions, principals, and optionally conditions to create more granular access controls.<br><br>- `actions`: A list of actions the policy allows or denies.<br>- `principals`: A list of principal IDs to which the policy will apply.<br>- `conditions`: (Optional) Conditions for when the policy is in effect.<br><br>Example usage:<br>[<br>  {<br>    actions = ["sqs:SendMessage", "sqs:ReceiveMessage"]<br>    principals = { type = "AWS", identifiers = ["arn:aws:iam::123456789012:user/ExampleUser"] }<br>    conditions = [<br>      {<br>        test = "ArnEquals"<br>        variable = "aws:SourceArn"<br>        values = ["arn:aws:sns:us-east-1:123456789012:my-sns-topic"]<br>      }<br>    ]<br>  }<br>] | <pre>list(object({<br>    actions    = list(string)<br>    principals = object({ type = string, identifiers = list(string) })<br>    conditions = optional(list(object({<br>      test     = string<br>      variable = string<br>      values   = list(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_sqs_queue_arn"></a> [dlq\_sqs\_queue\_arn](#output\_dlq\_sqs\_queue\_arn) | The ARN of the Dead Letter SQS queue. |
| <a name="output_dlq_sqs_queue_url"></a> [dlq\_sqs\_queue\_url](#output\_dlq\_sqs\_queue\_url) | The URL of the Dead Letter SQS queue. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_sqs_queue_arn"></a> [sqs\_queue\_arn](#output\_sqs\_queue\_arn) | The ARN of the SQS queue. |
| <a name="output_sqs_queue_url"></a> [sqs\_queue\_url](#output\_sqs\_queue\_url) | The URL of the SQS queue. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
