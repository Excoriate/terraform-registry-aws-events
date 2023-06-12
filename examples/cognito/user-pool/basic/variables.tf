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
    name                        = string
    user_pool_name              = optional(string, null)
    alias_attributes            = optional(list(string), ["email", "preferred_username"])
    username_attributes         = optional(list(string), null)
    deletion_protection_enabled = optional(bool, false) // maps to deletion_protection attribute.
    auto_verified_attributes    = optional(list(string), null)
    is_username_case_sensitive  = optional(bool, true)
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
    name                = string
    enable_mfa          = optional(bool, false)
    disable_mfa         = optional(bool, true) // set by default
    enable_optional_mfa = optional(bool, false)
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
