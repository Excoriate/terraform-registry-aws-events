<!-- BEGIN_TF_DOCS -->
# ☁️ Cognito User Pool
## Description

This module provides the following capabilities:
* 🚀 **Lambda configuration**: It supports the addition of lambda triggers.
* 🔒 **User Pool Management**: This module supports the creation and configuration of AWS Cognito User Pools. You can define attributes, password policies, and more.
* 🔑 **MFA Configuration**: This module supports the setup of Multi-Factor Authentication (MFA) for your user pool.
* 📧 **Email and SMS Configuration**: You can configure the email and SMS settings for verification and multi-factor authentication.
* 🚀 **Schema Attributes**: You can set up custom schema attributes for your user pool.
* 🎣 **Trigger Events**: You can specify AWS Lambda functions to handle events that occur during user pool operations.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/cognito/user-pool"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // Specific module configuration
  user_pool_config                     = var.user_pool_config
  email_verification_config            = var.email_verification_config
  mfa_configuration_config             = var.mfa_configuration_config
  sms_verification_config              = var.sms_verification_config
  admin_create_user_config             = var.admin_create_user_config
  account_recovery_config              = var.account_recovery_config
  device_configuration                 = var.device_configuration
  email_configuration                  = var.email_configuration
  sms_configuration                    = var.sms_configuration
  password_policy_config               = var.password_policy_config
  schema_attributes_config             = var.schema_attributes_config
  verification_message_template_config = var.verification_message_template_config
  lambda_config                        = var.lambda_config
}
```
## Recipes
### Very basic configuration.
```hcl
aws_region = "us-east-1"
is_enabled = true

user_pool_config = {
  name = "userpool1"
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
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_recovery_config"></a> [account\_recovery\_config](#input\_account\_recovery\_config) | List of account recovery configurations to create. These attributes are used in order<br>to set the account recovery mechanisms that are available to the user when they sign up. | <pre>object({<br>    name = string<br>    recovery_mechanisms = optional(list(object({<br>      name     = string<br>      priority = number<br>    })), null)<br>  })</pre> | `null` | no |
| <a name="input_admin_create_user_config"></a> [admin\_create\_user\_config](#input\_admin\_create\_user\_config) | List of admin create user configurations to create. These attributes are used in order<br>to set the admin create user message that is sent to the user when they sign up. | <pre>object({<br>    name                         = string<br>    allow_admin_create_user_only = optional(bool, false)<br>    invite_message_template = optional(object({<br>      email_message = optional(string, null)<br>      email_subject = optional(string, null)<br>      sms_message   = optional(string, null)<br>    }), null)<br>  })</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_device_configuration"></a> [device\_configuration](#input\_device\_configuration) | The device configuration to create. These attributes are used in order<br>to set the device configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-devices.html | <pre>object({<br>    name                                  = string<br>    device_only_remembered_on_user_prompt = optional(bool, false)<br>    challenge_required_on_new_device      = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_email_configuration"></a> [email\_configuration](#input\_email\_configuration) | The email configuration to create. These attributes are used in order<br>to set the email configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html | <pre>object({<br>    name                   = string<br>    configuration_set      = optional(string, null)<br>    email_sending_account  = optional(string, "COGNITO_DEFAULT")<br>    from_email_address     = optional(string, null)<br>    reply_to_email_address = optional(string, null)<br>    source_arn             = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_email_verification_config"></a> [email\_verification\_config](#input\_email\_verification\_config) | List of email verification configurations to create. These attributes are used in order<br>to set the email verification message that is sent to the user when they sign up. | <pre>object({<br>    name                       = string<br>    email_verification_subject = string<br>    email_verification_message = string<br>  })</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_lambda_config"></a> [lambda\_config](#input\_lambda\_config) | The lambda configuration to create. These attributes are used in order<br>to set the lambda configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda.html | <pre>object({<br>    name                           = string<br>    create_auth_challenge          = optional(string, null)<br>    custom_message                 = optional(string, null)<br>    define_auth_challenge          = optional(string, null)<br>    post_authentication            = optional(string, null)<br>    post_confirmation              = optional(string, null)<br>    pre_authentication             = optional(string, null)<br>    pre_sign_up                    = optional(string, null)<br>    pre_token_generation           = optional(string, null)<br>    user_migration                 = optional(string, null)<br>    verify_auth_challenge_response = optional(string, null)<br>    kms_key_id                     = optional(string, null)<br>    custom_email_sender = optional(object({<br>      lambda_arn     = optional(string, null)<br>      lambda_version = optional(string, null)<br>    }), null)<br>    custom_sms_sender = optional(object({<br>      lambda_arn     = optional(string, null)<br>      lambda_version = optional(string, null)<br>    }), null)<br>  })</pre> | `null` | no |
| <a name="input_mfa_configuration_config"></a> [mfa\_configuration\_config](#input\_mfa\_configuration\_config) | List of MFA configurations to create. The options are:<br>  - enable\_mfa: Enable MFA for all users.<br>  - disable\_mfa: Disable MFA for all users.<br>  - enable\_optional\_mfa: Enable MFA for all users, but allow them to choose not to use it.<br>By default, it's set to 'disable\_mfa'. | <pre>object({<br>    name                     = string<br>    enable_mfa               = optional(bool, false)<br>    disable_mfa              = optional(bool, true) // set by default<br>    enable_optional_mfa      = optional(bool, false)<br>    allow_software_mfa_token = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_password_policy_config"></a> [password\_policy\_config](#input\_password\_policy\_config) | The password policy configuration to create. These attributes are used in order<br>to set the password policy configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-password-policies.html | <pre>object({<br>    name                             = string<br>    minimum_length                   = optional(number, 8)<br>    require_lowercase                = optional(bool, true)<br>    require_uppercase                = optional(bool, true)<br>    require_numbers                  = optional(bool, true)<br>    require_symbols                  = optional(bool, true)<br>    temporary_password_validity_days = optional(number, 7)<br>  })</pre> | `null` | no |
| <a name="input_schema_attributes_config"></a> [schema\_attributes\_config](#input\_schema\_attributes\_config) | The schema attributes configuration to create. These attributes are used in order<br>to set the schema attributes configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html | <pre>list(object({<br>    name                     = string<br>    attribute_name           = string<br>    attribute_data_type      = string<br>    developer_only_attribute = optional(bool, false)<br>    mutable                  = optional(bool, true)<br>    required                 = optional(bool, false)<br>    string_attribute_constraints = optional(object({<br>      max_length = optional(string, null)<br>      min_length = optional(string, null)<br>    }), null)<br>    number_attribute_constraints = optional(object({<br>      max_value = optional(string, null)<br>      min_value = optional(string, null)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_sms_configuration"></a> [sms\_configuration](#input\_sms\_configuration) | The SMS configuration to create. These attributes are used in order<br>to set the SMS configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-configuration.html | <pre>object({<br>    name           = string<br>    external_id    = optional(string, null)<br>    sns_caller_arn = optional(string, null)<br>    sns_region     = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_sms_verification_config"></a> [sms\_verification\_config](#input\_sms\_verification\_config) | List of SMS verification configurations to create. These attributes are used in order<br>to set the SMS verification message that is sent to the user when they sign up. | <pre>object({<br>    name                       = string<br>    sms_verification_message   = string<br>    sms_authentication_message = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_user_pool_config"></a> [user\_pool\_config](#input\_user\_pool\_config) | List of user pool configurations to create. These attributes are used in order<br>to set additional user attributes that can be used for sign-in purposes, along with the standard<br>username or email. They provide more flexibility in user identification. For example,<br>a user could log in with their phone number or a custom attribute like a social security number,<br>as long as these attributes are set as alias attributes.<br>The 'alias\_attributes' and the 'username\_attributes' are mutually exclusive. | <pre>object({<br>    name                                          = string<br>    user_pool_name                                = optional(string, null)<br>    alias_attributes                              = optional(list(string), ["email", "preferred_username"])<br>    username_attributes                           = optional(list(string), null)<br>    deletion_protection_enabled                   = optional(bool, false) // maps to deletion_protection attribute.<br>    auto_verified_attributes                      = optional(list(string), null)<br>    is_username_case_sensitive                    = optional(bool, true)<br>    user_pool_add_ons_security_mode               = optional(string, null)<br>    attributes_require_verification_before_update = optional(list(string), null)<br>  })</pre> | n/a | yes |
| <a name="input_verification_message_template_config"></a> [verification\_message\_template\_config](#input\_verification\_message\_template\_config) | The verification message template configuration to create. These attributes are used in order<br>to set the verification message template configuration that is available to the user when they sign up.<br>For more information about this specific attribute please refer to the following link:<br>https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html | <pre>object({<br>    name                  = string<br>    default_email_option  = optional(string, null)<br>    email_message_by_link = optional(string, null)<br>    email_message         = optional(string, null)<br>    email_subject         = optional(string, null)<br>    email_subject_by_link = optional(string, null)<br>    sms_message           = optional(string, null)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_user_pool_configuration"></a> [user\_pool\_configuration](#output\_user\_pool\_configuration) | The user pool configuration |
<!-- END_TF_DOCS -->