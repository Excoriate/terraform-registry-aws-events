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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/eventbridge/eventbridge-permissions | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_policies"></a> [attach\_policies](#input\_attach\_policies) | This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported<br>attributes are:<br>- name: The name of the role<br>- policy\_json\_docs: A list of JSON documents that describe the policy<br>- policy\_arns: A list of ARNs of IAM policies to attach to the role | <pre>object({<br>    role_name = string<br>    policy_json_docs = optional(list(object({<br>      policy_name = string<br>      policy_doc = object({<br>        Version = string<br>        Statement = list(object({<br>          Sid      = optional(string, null)<br>          Effect   = string<br>          Action   = list(string)<br>          Resource = list(string)<br>        }))<br>      })<br>    })), [])<br>    policy_arns = optional(list(object({<br>      policy_name = string<br>      policy_arn  = string<br>    })), [])<br>  })</pre> | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_lambda_permissions_config"></a> [lambda\_permissions\_config](#input\_lambda\_permissions\_config) | This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported<br>attributes are:<br>- name: The name of the role<br>- enable\_lambda\_permissions: Specifies to attach the 'AWSLambdaBasicExecutionRole' policy to the role. Defaults to false<br>- lambda\_arns: The ARN of the AWS Lambda function | <pre>object({<br>    name          = string<br>    enable_lambda = optional(bool, false)<br>    lambda_arns   = optional(list(string), [])<br>  })</pre> | `null` | no |
| <a name="input_role_config"></a> [role\_config](#input\_role\_config) | This object configures an IAM role that can be used for an 'Eventbridge' rule. The current supported<br>attributes are:<br>- name: The name of the role<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the role<br>- force\_detach\_policies: Specifies to force detaching any policies the role has before destroying it. Defaults to false<br>- trusted\_entities: A list of AWS account IDs (without hyphens) or AWS Organizations entity IDs (such as 'o-EXAMPLE') that are associated with the role | <pre>object({<br>    // General settings<br>    name                  = string<br>    permissions_boundary  = optional(string, null)<br>    force_detach_policies = optional(bool, false)<br>    trusted_entities      = optional(list(string), [])<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_bridge_policy"></a> [event\_bridge\_policy](#output\_event\_bridge\_policy) | The ARN of the IAM policy for EventBridge. |
| <a name="output_event_bridge_policy_doc"></a> [event\_bridge\_policy\_doc](#output\_event\_bridge\_policy\_doc) | The IAM policy for EventBridge. |
| <a name="output_event_bridge_role_arn"></a> [event\_bridge\_role\_arn](#output\_event\_bridge\_role\_arn) | The ARN of the IAM role for EventBridge. |
| <a name="output_event_bridge_role_id"></a> [event\_bridge\_role\_id](#output\_event\_bridge\_role\_id) | The ID of the IAM role for EventBridge. |
| <a name="output_event_bridge_role_name"></a> [event\_bridge\_role\_name](#output\_event\_bridge\_role\_name) | The name of the IAM role for EventBridge. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->