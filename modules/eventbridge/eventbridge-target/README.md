<!-- BEGIN_TF_DOCS -->
# ☁️ Event bridge target
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

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
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_target_lambda_config"></a> [target\_lambda\_config](#input\_target\_lambda\_config) | n/a | <pre>list(object({<br>    // General settings<br>    name = string<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
