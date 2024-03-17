<!-- BEGIN_TF_DOCS -->
# ☁️ Event bridge rule
## Description

This module creates an event bridge rule, with the following capabilities:
* 🚀 **Event bridge rule**: Event bridge rule with the specified name.
* 🚀 **Event pattern**: Event pattern to filter the events that will trigger the rule.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source               = "../../../../modules/eventbridge/eventbridge-rule"
  is_enabled           = var.is_enabled
  rule_config          = var.rule_config
  aws_region           = var.aws_region
  rule_event_pattern   = var.rule_event_pattern
  trusted_entities     = var.trusted_entities
  permissions_boundary = var.permissions_boundary
}
```

Simple example of a basic implementation.
```hcl
aws_region = "us-east-1"
is_enabled = true

rule_config = [
  {
    name                = "rule1"
    description         = "rule1 description"
    schedule_expression = "rate(5 minutes)"
  }
]
```

Example where multiple event rules are created at once.
```hcl
aws_region = "us-east-1"
is_enabled = true

rule_config = [
  {
    name                = "rule1"
    description         = "rule1 description"
    schedule_expression = "rate(5 minutes)"
  },
  {
    name                = "rule2"
    description         = "rule2 description"
    schedule_expression = "rate(10 minutes)"
  },
  {
    name        = "rule3"
    description = "rule3 description"
  },
]
```

Example where an event pattern is passed.
```hcl
aws_region = "us-east-1"
is_enabled = true

rule_config = [
  {
    name                = "rule1"
    description         = "rule1 description"
    schedule_expression = "rate(5 minutes)"
  }
]

rule_event_pattern = [
  {
    name = "rule1"
    source = [
      "aws.health"
    ],
    detail-type = [
      "AWS Health Event"
    ],
    detail = {
      service = [
        "EC2"
      ],
      eventTypeCategory = [
        "issue"
      ]
    }
  }
]
```

For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "event_rule_id" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.id]
  description = "The ID of the CloudWatch Event Rule."
}

output "event_rule_arn" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.arn]
  description = "The ARN of the CloudWatch Event Rule."
}

output "event_rule_name" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.name]
  description = "The name of the CloudWatch Event Rule."
}

output "event_rule_description" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.description]
  description = "The description of the CloudWatch Event Rule."
}

output "event_rule_event_pattern" {
  value       = [for r in aws_cloudwatch_event_rule.this : r.event_pattern]
  description = "The event pattern of the CloudWatch Event Rule."
}

output "event_rule_iam_role_id" {
  value       = [for a in aws_iam_role.this : a.id]
  description = "The IAM role ARN of the CloudWatch Event Rule."
}

output "event_rule_iam_role_arn" {
  value       = [for a in aws_iam_role.this : a.arn]
  description = "The IAM role ARN of the CloudWatch Event Rule."
}

output "event_rule_iam_role_name" {
  value       = [for a in aws_iam_role.this : a.name]
  description = "The IAM role name of the CloudWatch Event Rule."
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
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role that is created for the event bus. | `string` | `null` | no |
| <a name="input_rule_config"></a> [rule\_config](#input\_rule\_config) | A list of objects that contains the configuration for each rule.<br> The following keys are supported:<br>  - name: (Required) The name of the rule.<br>  - is\_enabled: (Optional) Indicates whether the rule is enabled or disabled.<br>  - description: (Optional) A description of the rule.<br>  - event\_bus\_name: (Optional) The name of the event bus associated with the rule.<br>  - schedule\_expression: (Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).<br>  - role\_arn: (Optional) The Amazon Resource Name (ARN) of the IAM role associated with the rule.<br>  - disable\_default\_role: (Optional) Indicates whether the rule is managed by AWS or created by the customer. | <pre>list(object({<br>    // General settings<br>    name                 = string<br>    is_enabled           = optional(bool, true)<br>    description          = optional(string, null)<br>    event_bus_name       = optional(string, null)<br>    schedule_expression  = optional(string, null)<br>    role_arn             = optional(string, null)<br>    disable_default_role = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rule_event_pattern"></a> [rule\_event\_pattern](#input\_rule\_event\_pattern) | The event pattern of the rule. | <pre>list(object({<br>    name        = string<br>    rule_name   = optional(string, null)<br>    source      = optional(list(string), null)<br>    account     = optional(list(string), null)<br>    region      = optional(list(string), null)<br>    detail-type = optional(list(string), null)<br>    resources   = optional(list(string), null)<br>    detail      = optional(map(any), {})<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_trusted_entities"></a> [trusted\_entities](#input\_trusted\_entities) | A list of AWS account IDs, or * to specify all accounts. This is used to determine which other AWS accounts can put events to this account's default event bus. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_event_rule_arn"></a> [event\_rule\_arn](#output\_event\_rule\_arn) | The ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_description"></a> [event\_rule\_description](#output\_event\_rule\_description) | The description of the CloudWatch Event Rule. |
| <a name="output_event_rule_event_pattern"></a> [event\_rule\_event\_pattern](#output\_event\_rule\_event\_pattern) | The event pattern of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_arn"></a> [event\_rule\_iam\_role\_arn](#output\_event\_rule\_iam\_role\_arn) | The IAM role ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_id"></a> [event\_rule\_iam\_role\_id](#output\_event\_rule\_iam\_role\_id) | The IAM role ARN of the CloudWatch Event Rule. |
| <a name="output_event_rule_iam_role_name"></a> [event\_rule\_iam\_role\_name](#output\_event\_rule\_iam\_role\_name) | The IAM role name of the CloudWatch Event Rule. |
| <a name="output_event_rule_id"></a> [event\_rule\_id](#output\_event\_rule\_id) | The ID of the CloudWatch Event Rule. |
| <a name="output_event_rule_name"></a> [event\_rule\_name](#output\_event\_rule\_name) | The name of the CloudWatch Event Rule. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
