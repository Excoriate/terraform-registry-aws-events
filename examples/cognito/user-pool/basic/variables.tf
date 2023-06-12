variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "user_pool_config" {
  type = object({
    name                                          = string
    user_pool_name                                = optional(string, null)
    alias_attributes                              = optional(list(string), ["email", "preferred_username"])
    username_attributes                           = optional(list(string), null)
    deletion_protection_enabled                   = optional(bool, false) // maps to deletion_protection attribute.
    auto_verified_attributes                      = optional(list(string), null)
    is_username_case_sensitive                    = optional(bool, true)
    user_pool_add_ons_security_mode               = optional(string, null)
    attributes_require_verification_before_update = optional(list(string), null)
  })
  description = <<EOF
  List of user pool configurations to create. These attributes are used in order
to set additional user attributes that can be used for sign-in purposes, along with the standard
username or email. They provide more flexibility in user identification. For example,
a user could log in with their phone number or a custom attribute like a social security number,
as long as these attributes are set as alias attributes.
The 'alias_attributes' and the 'username_attributes' are mutually exclusive.
EOF
}

variable "email_verification_config" {
  type = object({
    name                       = string
    email_verification_subject = string
    email_verification_message = string
  })
  description = <<EOF
  List of email verification configurations to create. These attributes are used in order
to set the email verification message that is sent to the user when they sign up.
EOF
  default     = null
}

variable "sms_verification_config" {
  type = object({
    name                       = string
    sms_verification_message   = string
    sms_authentication_message = string
  })
  description = <<EOF
  List of SMS verification configurations to create. These attributes are used in order
to set the SMS verification message that is sent to the user when they sign up.
EOF
  default     = null
}

variable "mfa_configuration_config" {
  type = object({
    name                     = string
    enable_mfa               = optional(bool, false)
    disable_mfa              = optional(bool, true) // set by default
    enable_optional_mfa      = optional(bool, false)
    allow_software_mfa_token = optional(bool, false)
  })
  description = <<EOF
  List of MFA configurations to create. The options are:
  - enable_mfa: Enable MFA for all users.
  - disable_mfa: Disable MFA for all users.
  - enable_optional_mfa: Enable MFA for all users, but allow them to choose not to use it.
By default, it's set to 'disable_mfa'.
EOF
  default     = null
}

variable "admin_create_user_config" {
  type = object({
    name                         = string
    allow_admin_create_user_only = optional(bool, false)
    invite_message_template = optional(object({
      email_message = optional(string, null)
      email_subject = optional(string, null)
      sms_message   = optional(string, null)
    }), null)
  })
  description = <<EOF
  List of admin create user configurations to create. These attributes are used in order
to set the admin create user message that is sent to the user when they sign up.
EOF
  default     = null
}

variable "account_recovery_config" {
  type = object({
    name = string
    recovery_mechanisms = optional(list(object({
      name     = string
      priority = number
    })), null)
  })
  description = <<EOF
  List of account recovery configurations to create. These attributes are used in order
to set the account recovery mechanisms that are available to the user when they sign up.
EOF
  default     = null
}

variable "device_configuration" {
  type = object({
    name                                  = string
    device_only_remembered_on_user_prompt = optional(bool, false)
    challenge_required_on_new_device      = optional(bool, false)
  })
  description = <<EOF
  The device configuration to create. These attributes are used in order
to set the device configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-devices.html
EOF
  default     = null
}

variable "email_configuration" {
  type = object({
    name                   = string
    configuration_set      = optional(string, null)
    email_sending_account  = optional(string, "COGNITO_DEFAULT")
    from_email_address     = optional(string, null)
    reply_to_email_address = optional(string, null)
    source_arn             = optional(string, null)
  })
  description = <<EOF
  The email configuration to create. These attributes are used in order
to set the email configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html
EOF
  default     = null
}

variable "sms_configuration" {
  type = object({
    name           = string
    external_id    = optional(string, null)
    sns_caller_arn = optional(string, null)
    sns_region     = optional(string, null)
  })
  description = <<EOF
The SMS configuration to create. These attributes are used in order
to set the SMS configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-configuration.html
EOF
  default     = null
}

variable "password_policy_config" {
  type = object({
    name                             = string
    minimum_length                   = optional(number, 8)
    require_lowercase                = optional(bool, true)
    require_uppercase                = optional(bool, true)
    require_numbers                  = optional(bool, true)
    require_symbols                  = optional(bool, true)
    temporary_password_validity_days = optional(number, 7)
  })
  description = <<EOF
The password policy configuration to create. These attributes are used in order
to set the password policy configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-password-policies.html
EOF
  default     = null
}

variable "schema_attributes_config" {
  type = list(object({
    name                     = string
    attribute_name           = string
    attribute_data_type      = string
    developer_only_attribute = optional(bool, false)
    mutable                  = optional(bool, true)
    required                 = optional(bool, false)
    string_attribute_constraints = optional(object({
      max_length = optional(string, null)
      min_length = optional(string, null)
    }), null)
    number_attribute_constraints = optional(object({
      max_value = optional(string, null)
      min_value = optional(string, null)
    }), null)
  }))
  description = <<EOF
The schema attributes configuration to create. These attributes are used in order
to set the schema attributes configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html
EOF
  default     = null
}

variable "verification_message_template_config" {
  type = object({
    name                  = string
    default_email_option  = optional(string, null)
    email_message_by_link = optional(string, null)
    email_message         = optional(string, null)
    email_subject         = optional(string, null)
    email_subject_by_link = optional(string, null)
    sms_message           = optional(string, null)
  })
  description = <<EOF
The verification message template configuration to create. These attributes are used in order
to set the verification message template configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html
EOF
  default     = null
}

variable "lambda_config" {
  type = object({
    name                           = string
    create_auth_challenge          = optional(string, null)
    custom_message                 = optional(string, null)
    define_auth_challenge          = optional(string, null)
    post_authentication            = optional(string, null)
    post_confirmation              = optional(string, null)
    pre_authentication             = optional(string, null)
    pre_sign_up                    = optional(string, null)
    pre_token_generation           = optional(string, null)
    user_migration                 = optional(string, null)
    verify_auth_challenge_response = optional(string, null)
    kms_key_id                     = optional(string, null)
    custom_email_sender = optional(object({
      lambda_arn     = optional(string, null)
      lambda_version = optional(string, null)
    }), null)
    custom_sms_sender = optional(object({
      lambda_arn     = optional(string, null)
      lambda_version = optional(string, null)
    }), null)
  })
  description = <<EOF
The lambda configuration to create. These attributes are used in order
to set the lambda configuration that is available to the user when they sign up.
For more information about this specific attribute please refer to the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda.html
EOF
  default     = null
}
