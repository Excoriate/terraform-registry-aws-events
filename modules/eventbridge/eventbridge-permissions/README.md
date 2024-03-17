<!-- BEGIN_TF_DOCS -->
# ☁️ Event bridge permissions
## Description

------------------------------------
Permissions passed through existing IAM
policies
------------------------------------

This is a custom module that bring out-of-the-fox permissions for common use-cases for eventbridge. It's just an abstraction that takes care of creating IAM roles, and a set of permissions for eventbridge.
* 🚀 **IAM role**: IAM role that will be created and attached to the eventbridge rule.
* 🚀 **IAM policy**: IAM policy that will be created and attached to the IAM role.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                    = "../../../../modules/eventbridge/eventbridge-permissions"
  is_enabled                = var.is_enabled
  aws_region                = var.aws_region
  role_config               = var.role_config
  lambda_permissions_config = var.lambda_permissions_config
  attach_policies           = var.attach_policies
}
```

Simple example of a basic implementation.
```hcl
aws_region = "us-east-1"
is_enabled = true

role_config = {
  name = "rule1"
}
```

Example where lambda permissions are set, in order to invoke an AWS Lambda function.
```hcl
aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

lambda_permissions_config = {
  name          = "eventbridge-role-1"
  enable_lambda = true
  lambda_arns   = ["arn:aws:lambda:us-east-1:123456789012:function:my-function"]
}
```

Example where custom IAM policy documents are passed.
```hcl
aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

attach_policies = {
  role_name = "eventbridge-role-1"
  policy_json_docs = [
    {
      policy_name = "eventbridge-policy-1"
      policy_doc = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "events:PutEvents",
            ]
            Effect   = "Allow"
            Resource = ["*"]
          },
        ]
      }
    },
    {
      policy_name = "eventbridge-policy-2"
      policy_doc = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "events:PutRule",
              "events:PutTargets",
              "events:DescribeRule",
              "events:RemoveTargets",
              "events:DeleteRule",
            ]
            Effect   = "Allow"
            Resource = ["*"]
          },
        ]
      }
    }
  ]
}
```

Example where custom policy ARNs are passed
```hcl
aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

attach_policies = {
  role_name = "eventbridge-role-1"
  policy_arns = [
    {
      policy_name = "eventbridge-policy-1"
      policy_arn  = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
    }
  ]
}
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
output "event_bridge_role_id" {
  value       = join("", [for role in aws_iam_role.this : role.id])
  description = "The ID of the IAM role for EventBridge."
}

output "event_bridge_role_name" {
  value       = join("", [for role in aws_iam_role.this : role.name])
  description = "The name of the IAM role for EventBridge."
}

output "event_bridge_role_arn" {
  value       = join("", [for role in aws_iam_role.this : role.arn])
  description = "The ARN of the IAM role for EventBridge."
}

output "event_bridge_policy" {
  value       = join("", [for policy in aws_iam_policy.lambda_policy : policy.arn])
  description = "The ARN of the IAM policy for EventBridge."
}

output "event_bridge_policy_doc" {
  value       = join("", [for policy in aws_iam_policy.lambda_policy : policy.policy])
  description = "The IAM policy for EventBridge."
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
| [aws_iam_policy.custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.custom_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom_policy_attachment_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_policies"></a> [attach\_policies](#input\_attach\_policies) | This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported<br>attributes are:<br>- name: The name of the role<br>- policy\_json\_docs: A list of JSON documents that describe the policy<br>- policy\_arns: A list of ARNs of IAM policies to attach to the role | <pre>object({<br>    role_name = string<br>    policy_json_docs = optional(list(object({<br>      policy_name = string<br>      policy_doc = object({<br>        Version = string<br>        Statement = list(object({<br>          Sid      = optional(string, null)<br>          Effect   = string<br>          Action   = list(string)<br>          Resource = list(string)<br>        }))<br>      })<br>    })), [])<br>    policy_arns = optional(list(object({<br>      policy_name = string<br>      policy_arn  = string<br>    })), [])<br>  })</pre> | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_lambda_permissions_config"></a> [lambda\_permissions\_config](#input\_lambda\_permissions\_config) | This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported<br>attributes are:<br>- name: The name of the role<br>- enable\_lambda\_permissions: Specifies to attach the 'AWSLambdaBasicExecutionRole' policy to the role. Defaults to false<br>- lambda\_arns: The ARN of the AWS Lambda function | <pre>object({<br>    name          = string<br>    enable_lambda = optional(bool, false)<br>    lambda_arns   = optional(list(string), [])<br>  })</pre> | `null` | no |
| <a name="input_role_config"></a> [role\_config](#input\_role\_config) | This object configures an IAM role that can be used for an 'Eventbridge' rule. The current supported<br>attributes are:<br>- name: The name of the role<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the role<br>- force\_detach\_policies: Specifies to force detaching any policies the role has before destroying it. Defaults to false<br>- trusted\_entities: A list of AWS account IDs (without hyphens) or AWS Organizations entity IDs (such as 'o-EXAMPLE') that are associated with the role | <pre>object({<br>    // General settings<br>    name                  = string<br>    permissions_boundary  = optional(string, null)<br>    force_detach_policies = optional(bool, false)<br>    trusted_entities      = optional(list(string), [])<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_event_bridge_policy"></a> [event\_bridge\_policy](#output\_event\_bridge\_policy) | The ARN of the IAM policy for EventBridge. |
| <a name="output_event_bridge_policy_doc"></a> [event\_bridge\_policy\_doc](#output\_event\_bridge\_policy\_doc) | The IAM policy for EventBridge. |
| <a name="output_event_bridge_role_arn"></a> [event\_bridge\_role\_arn](#output\_event\_bridge\_role\_arn) | The ARN of the IAM role for EventBridge. |
| <a name="output_event_bridge_role_id"></a> [event\_bridge\_role\_id](#output\_event\_bridge\_role\_id) | The ID of the IAM role for EventBridge. |
| <a name="output_event_bridge_role_name"></a> [event\_bridge\_role\_name](#output\_event\_bridge\_role\_name) | The name of the IAM role for EventBridge. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
