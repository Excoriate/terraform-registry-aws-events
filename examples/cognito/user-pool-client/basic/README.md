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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/cognito/user-pool-client | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_oauth_config"></a> [oauth\_config](#input\_oauth\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                                 = string<br>    allowed_oauth_flows_user_pool_client = optional(bool, false)<br>    allowed_oauth_flows                  = optional(list(string), null)<br>    allowed_oauth_scopes                 = optional(list(string), null)<br>    callback_urls                        = optional(list(string), null)<br>  }))</pre> | `null` | no |
| <a name="input_others_config"></a> [others\_config](#input\_others\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                          = string<br>    auth_session_validity         = optional(number, null)<br>    default_redirect_uri          = optional(string, null)<br>    explicit_auth_flows           = optional(list(string), null)<br>    generate_secret               = optional(bool, false)<br>    logout_urls                   = optional(list(string), null)<br>    read_attributes               = optional(list(string), null)<br>    supported_identity_providers  = optional(list(string), null)<br>    prevent_user_existence_errors = optional(string, null)<br>    write_attributes              = optional(list(string), null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_token_config"></a> [token\_config](#input\_token\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                    = string<br>    id_token_validity       = optional(number, null)<br>    access_token_validity   = optional(number, null)<br>    refresh_token_validity  = optional(number, null)<br>    enable_token_revocation = optional(bool, false)<br>    token_validity_units = optional(object({<br>      id_token      = optional(string, null)<br>      access_token  = optional(string, null)<br>      refresh_token = optional(string, null)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_user_pool_client_config"></a> [user\_pool\_client\_config](#input\_user\_pool\_client\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>This configuration supports multiple user pool clients. | <pre>list(object({<br>    name         = string<br>    user_pool_id = string<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_user_pool_client_configuration"></a> [user\_pool\_client\_configuration](#output\_user\_pool\_client\_configuration) | The user pool client configuration |
| <a name="output_user_pool_client_id"></a> [user\_pool\_client\_id](#output\_user\_pool\_client\_id) | The user pool client id |
| <a name="output_user_pool_client_secret"></a> [user\_pool\_client\_secret](#output\_user\_pool\_client\_secret) | The user pool client secret |
<!-- END_TF_DOCS -->
