<!-- BEGIN_TF_DOCS -->
# ☁️ Cognito Identity Provider
## Description

This module provides the following capabilities:
* 🚀 **Identity Provider Configuration**: It allows you to set up an identity provider for a user pool, including the provider name, type, and details such as the access token.
* 🔑 **Attribute Mapping**: This module supports the mapping of user pool attributes.
* 🎣 **Identity Providers**: You can specify a list of identity providers.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/cognito/identity-provider"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  identity_provider_config = [
    {
      name         = "userpooldomain1"
      user_pool_id = aws_cognito_user_pool.pool.id
      provider_name = "LoginWithAmazon"
      provider_type = "LoginWithAmazon"
      provider_details = {
        client_id     = "client_id"
        client_secret = "client_secret"
        authorize_scopes = "email, profile, openid"  # Added authorize_scopes
      }
    },
    {
      name         = "userpooldomain2"
      user_pool_id = aws_cognito_user_pool.pool2.id
      provider_name = "Google"
      provider_type = "Google"
      provider_details = {
        client_id     = "client_id"
        client_secret = "client_secret"
        authorize_scopes = "email, profile, openid"  # Added authorize_scopes
      }
    }
  ]

  identity_provider_optionals_config = var.identity_provider_optionals_config

  tags = var.tags
}

resource "aws_cognito_user_pool" "pool" {
  name = "userpool1"
}

resource "aws_cognito_user_pool" "pool2" {
  name = "userpool2"
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
| [aws_cognito_identity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_identity_provider_config"></a> [identity\_provider\_config](#input\_identity\_provider\_config) | List of identity provider configurations to create. The required arguments are described in the<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_identity_provider<br>These are:<br>  - name: Friendly identifier for the terraform resource to be created.<br>  - user\_pool\_id: The user pool ID.<br>  - provider\_name: The identity provider name. It can be a string with the following values: "Facebook", "Google",<br>    "LoginWithAmazon", "SignInWithApple", "OIDC", "SAML".<br>  - provider\_type: The identity provider type. It refers to the type of third party identity provider.<br>    "SAML" for SAML providers, "Facebook" for Facebook login, "Google" for Google login, and "LoginWithAmazon" for<br>    Login with Amazon.<br>  - provider\_details: The identity provider details, such as MetadataURL and MetadataFile. | <pre>list(object({<br>    name          = string<br>    user_pool_id  = string<br>    provider_name = string<br>    provider_type = string<br>    provider_details = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_identity_provider_optionals_config"></a> [identity\_provider\_optionals\_config](#input\_identity\_provider\_optionals\_config) | List of identity provider configurations to create. The required arguments are described in the<br>  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_identity_provider<br>These are:<br>  - name: Friendly identifier for the terraform resource to be created.<br>  - attribute\_mapping: A mapping of identity provider attributes to standard and custom user pool attributes.<br>  - idp\_identifiers: A list of identity provider identifiers. | <pre>list(object({<br>    name              = string<br>    attribute_mapping = optional(map(string), null)<br>    idp_identifiers   = optional(list(string), null)<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_identity_provider_attribute_mapping"></a> [identity\_provider\_attribute\_mapping](#output\_identity\_provider\_attribute\_mapping) | The identity provider attribute mapping |
| <a name="output_identity_provider_config"></a> [identity\_provider\_config](#output\_identity\_provider\_config) | The user pool domain configuration |
| <a name="output_identity_provider_id"></a> [identity\_provider\_id](#output\_identity\_provider\_id) | The identity provider id |
| <a name="output_identity_provider_name"></a> [identity\_provider\_name](#output\_identity\_provider\_name) | The identity provider name |
| <a name="output_identity_provider_provider_details"></a> [identity\_provider\_provider\_details](#output\_identity\_provider\_provider\_details) | The identity provider provider details |
| <a name="output_identity_provider_type"></a> [identity\_provider\_type](#output\_identity\_provider\_type) | The identity provider type |
| <a name="output_identity_provider_user_pool_id"></a> [identity\_provider\_user\_pool\_id](#output\_identity\_provider\_user\_pool\_id) | The identity provider user pool id |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->