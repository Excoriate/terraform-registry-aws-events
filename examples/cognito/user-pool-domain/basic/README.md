<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/cognito/user-pool-domain | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool.pool2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_user_pool_domain_config"></a> [user\_pool\_domain\_config](#input\_user\_pool\_domain\_config) | List of objects containing the configuration for the user pool domain.<br>  name: The name of the domain.<br>  domain: The domain string.<br>  user\_pool\_id: The user pool ID.<br>  certificate\_arn: The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.<br>For more information see https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain.html | <pre>list(object({<br>    name            = string<br>    domain          = string<br>    user_pool_id    = string<br>    certificate_arn = optional(string, null)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_user_pool_domain_certificate_arn"></a> [user\_pool\_domain\_certificate\_arn](#output\_user\_pool\_domain\_certificate\_arn) | The user pool domain certificate arn |
| <a name="output_user_pool_domain_config"></a> [user\_pool\_domain\_config](#output\_user\_pool\_domain\_config) | The user pool domain configuration |
| <a name="output_user_pool_domain_domain_name"></a> [user\_pool\_domain\_domain\_name](#output\_user\_pool\_domain\_domain\_name) | The user pool domain name |
| <a name="output_user_pool_domain_id"></a> [user\_pool\_domain\_id](#output\_user\_pool\_domain\_id) | The user pool domain id |
<!-- END_TF_DOCS -->
