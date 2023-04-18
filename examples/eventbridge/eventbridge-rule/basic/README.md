<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/eventbridge/eventbridge-rule | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role that is created for the event bus. | `string` | `null` | no |
| <a name="input_rule_config"></a> [rule\_config](#input\_rule\_config) | A list of objects that contains the configuration for each rule.<br> The following keys are supported:<br>  - name: (Required) The name of the rule.<br>  - is\_enabled: (Optional) Indicates whether the rule is enabled or disabled.<br>  - description: (Optional) A description of the rule.<br>  - event\_bus\_name: (Optional) The name of the event bus associated with the rule.<br>  - schedule\_expression: (Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).<br>  - role\_arn: (Optional) The Amazon Resource Name (ARN) of the IAM role associated with the rule.<br>  - disable\_default\_role: (Optional) Indicates whether the rule is managed by AWS or created by the customer. | <pre>list(object({<br>    // General settings<br>    name                 = string<br>    is_enabled           = optional(bool, true)<br>    description          = optional(string, null)<br>    event_bus_name       = optional(string, null)<br>    schedule_expression  = optional(string, null)<br>    role_arn             = optional(string, null)<br>    disable_default_role = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rule_event_pattern"></a> [rule\_event\_pattern](#input\_rule\_event\_pattern) | The event pattern of the rule. | <pre>list(object({<br>    name        = string<br>    rule_name   = optional(string, null)<br>    source      = optional(list(string), null)<br>    account     = optional(list(string), null)<br>    region      = optional(list(string), null)<br>    detail-type = optional(list(string), null)<br>    resources   = optional(list(string), null)<br>    detail      = optional(map(any), {})<br>  }))</pre> | `null` | no |
| <a name="input_trusted_entities"></a> [trusted\_entities](#input\_trusted\_entities) | A list of AWS account IDs, or * to specify all accounts. This is used to determine which other AWS accounts can put events to this account's default event bus. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_rule_arn"></a> [event\_rule\_arn](#output\_event\_rule\_arn) | The ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_description"></a> [event\_rule\_description](#output\_event\_rule\_description) | The description of the CloudWatch Event Rule. |
| <a name="output_event_rule_event_pattern"></a> [event\_rule\_event\_pattern](#output\_event\_rule\_event\_pattern) | The event pattern of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_arn"></a> [event\_rule\_iam\_role\_arn](#output\_event\_rule\_iam\_role\_arn) | The IAM role ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_id"></a> [event\_rule\_iam\_role\_id](#output\_event\_rule\_iam\_role\_id) | The IAM role ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_name"></a> [event\_rule\_iam\_role\_name](#output\_event\_rule\_iam\_role\_name) | The IAM role name of the CloudWatch Event Rule. |
| <a name="output_event_rule_id"></a> [event\_rule\_id](#output\_event\_rule\_id) | The ID of the CloudWatch Event Rule. |
| <a name="output_event_rule_name"></a> [event\_rule\_name](#output\_event\_rule\_name) | The name of the CloudWatch Event Rule. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
