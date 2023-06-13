<!-- BEGIN_TF_DOCS -->
# ☁️ Cognito User Pool Domain
## Description

This module provides the following capabilities:
* 🚀 **Domain Configuration**: This module supports the creation and configuration of AWS Cognito User Pool Domains. You can set up a domain for your user pool.
* 🌐 **Custom Domain**: This module allows you to configure a custom domain for your user pool.
* 💼 **Domain Management**: This module supports the management of user pool domains. You can enable or disable domains as needed.
* 🔒 **Security Configuration**: This module supports the setup of HTTPS for the user pool domain.
* 🔑 **SSL Configuration**: You can configure SSL certificate for your custom domain.
* 🌟 **Usability**: This module simplifies the process of domain setup and management for your user pool.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/cognito/user-pool-domain"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_domain_config = [
    {
      name         = "userpooldomain1"
      user_pool_id = aws_cognito_user_pool.pool.id
      domain     = "exampleother"
    },
    // mobile client
    {
      name         = "userpooldomain2"
      user_pool_id = aws_cognito_user_pool.pool2.id
      domain      = "exampledifferent"
    }
  ]

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
| [aws_cognito_user_pool_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

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
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_user_pool_domain_config"></a> [user\_pool\_domain\_config](#input\_user\_pool\_domain\_config) | List of objects containing the configuration for the user pool domain.<br>  name: The name of the domain.<br>  domain: The domain string.<br>  user\_pool\_id: The user pool ID.<br>  certificate\_arn: The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.<br>For more information see https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain.html | <pre>list(object({<br>    name         = string<br>    domain       = string<br>    user_pool_id = string<br>    certificate_arn = optional(string, null)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_user_pool_domain_certificate_arn"></a> [user\_pool\_domain\_certificate\_arn](#output\_user\_pool\_domain\_certificate\_arn) | The user pool domain certificate arn |
| <a name="output_user_pool_domain_config"></a> [user\_pool\_domain\_config](#output\_user\_pool\_domain\_config) | The user pool domain configuration |
| <a name="output_user_pool_domain_domain_name"></a> [user\_pool\_domain\_domain\_name](#output\_user\_pool\_domain\_domain\_name) | The user pool domain name |
| <a name="output_user_pool_domain_id"></a> [user\_pool\_domain\_id](#output\_user\_pool\_domain\_id) | The user pool domain id |
<!-- END_TF_DOCS -->
