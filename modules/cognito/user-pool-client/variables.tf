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
variable "user_pool_client_config" {
  type = list(object({
    name         = string
    user_pool_id = string
  }))
  description = <<EOF
  Configuration for the user pool client. For more information, see the following link:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
This configuration supports multiple user pool clients.
EOF
}


variable "oauth_config" {
  type = list(object({
    name                                 = string
    allowed_oauth_flows_user_pool_client = optional(bool, false)
    allowed_oauth_flows                  = optional(list(string), null)
    allowed_oauth_scopes                 = optional(list(string), null)
    callback_urls                        = optional(list(string), null)
  }))
  description = <<EOF
  Configuration for the user pool client. For more information, see the following link:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
For a detailed description of the parameters, see the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html
EOF
  default     = null
}

variable "token_config" {
  type = list(object({
    name                    = string
    id_token_validity       = optional(number, null)
    access_token_validity   = optional(number, null)
    refresh_token_validity  = optional(number, null)
    enable_token_revocation = optional(bool, false)
    token_validity_units = optional(object({
      id_token      = optional(string, null)
      access_token  = optional(string, null)
      refresh_token = optional(string, null)
    }), null)
  }))
  description = <<EOF
  Configuration for the user pool client. For more information, see the following link:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
For a detailed description of the parameters, see the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html
EOF
  default     = null
}

variable "others_config" {
  type = list(object({
    name                          = string
    auth_session_validity         = optional(number, null)
    default_redirect_uri          = optional(string, null)
    explicit_auth_flows           = optional(list(string), null)
    generate_secret               = optional(bool, false)
    logout_urls                   = optional(list(string), null)
    read_attributes               = optional(list(string), null)
    supported_identity_providers  = optional(list(string), null)
    prevent_user_existence_errors = optional(string, null)
    write_attributes              = optional(list(string), null)
  }))
  description = <<EOF
  Configuration for the user pool client. For more information, see the following link:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
For a detailed description of the parameters, see the following link:
https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html
EOF
  default     = null
}
