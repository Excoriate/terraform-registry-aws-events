<!-- BEGIN_TF_DOCS -->
# ☁️ Cognito User Pool Client
## Description

This module provides the following capabilities:
* 🚀 **App Client Configuration**: This module supports the creation and configuration of AWS Cognito User Pool Clients. You can set up App Clients with different settings for your user pool.
* 🔑 **OAuth Configuration**: You can configure OAuth 2.0 flow, which allows applications to request user authorization.
* 💼 **User Pool Client Management**: This module supports the management of multiple User Pool Clients. You can enable or disable clients as needed.
* 🔒 **Security Configuration**: This module supports the setup of client secret and token validity settings.
* 🚀 **Read and Write Attributes**: You can set up read and write attributes for your User Pool Client.
* 📧 **Refresh Token Policy**: This module allows you to establish the refresh token expiration policy.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/cognito/user-pool-client"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_client_config = [
    {
      name         = "userpoolclient1"
      user_pool_id = aws_cognito_user_pool.pool.id
    },
    // mobile client
    {
      name         = "userpoolclient2"
      user_pool_id = aws_cognito_user_pool.pool.id
    }
  ]
  tags = var.tags

  oauth_config  = var.oauth_config
  token_config  = var.token_config
  others_config = var.others_config
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}
```
## Recipes
### Very basic configuration.
```hcl
aws_region = "us-east-1"
is_enabled = true
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
| [aws_cognito_user_pool_client.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_oauth_config"></a> [oauth\_config](#input\_oauth\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                                 = string<br>    allowed_oauth_flows_user_pool_client = optional(bool, false)<br>    allowed_oauth_flows                  = optional(list(string), null)<br>    allowed_oauth_scopes                 = optional(list(string), null)<br>    callback_urls                        = optional(list(string), null)<br>  }))</pre> | `null` | no |
| <a name="input_others_config"></a> [others\_config](#input\_others\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                          = string<br>    auth_session_validity         = optional(number, null)<br>    default_redirect_uri          = optional(string, null)<br>    explicit_auth_flows           = optional(list(string), null)<br>    generate_secret               = optional(bool, false)<br>    logout_urls                   = optional(list(string), null)<br>    read_attributes               = optional(list(string), null)<br>    supported_identity_providers  = optional(list(string), null)<br>    prevent_user_existence_errors = optional(string, null)<br>    write_attributes              = optional(list(string), null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_token_config"></a> [token\_config](#input\_token\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>For a detailed description of the parameters, see the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html | <pre>list(object({<br>    name                    = string<br>    id_token_validity       = optional(number, null)<br>    access_token_validity   = optional(number, null)<br>    refresh_token_validity  = optional(number, null)<br>    enable_token_revocation = optional(bool, false)<br>    token_validity_units = optional(object({<br>      id_token      = optional(string, null)<br>      access_token  = optional(string, null)<br>      refresh_token = optional(string, null)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_user_pool_client_config"></a> [user\_pool\_client\_config](#input\_user\_pool\_client\_config) | Configuration for the user pool client. For more information, see the following link:<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client<br>This configuration supports multiple user pool clients. | <pre>list(object({<br>    name         = string<br>    user_pool_id = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_user_pool_client_configuration"></a> [user\_pool\_client\_configuration](#output\_user\_pool\_client\_configuration) | The user pool client configuration |
| <a name="output_user_pool_client_id"></a> [user\_pool\_client\_id](#output\_user\_pool\_client\_id) | The user pool client id |
| <a name="output_user_pool_client_secret"></a> [user\_pool\_client\_secret](#output\_user\_pool\_client\_secret) | The user pool client secret |
<!-- END_TF_DOCS -->
