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
variable "identity_provider_config" {
  type = list(object({
    name             = string
    user_pool_id     = string
    provider_name    = string
    provider_type    = string
    provider_details = map(string)
  }))
  description = <<EOF
  List of identity provider configurations to create. The required arguments are described in the
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_identity_provider
These are:
  - name: Friendly identifier for the terraform resource to be created.
  - user_pool_id: The user pool ID.
  - provider_name: The identity provider name. It can be a string with the following values: "Facebook", "Google",
    "LoginWithAmazon", "SignInWithApple", "OIDC", "SAML".
  - provider_type: The identity provider type. It refers to the type of third party identity provider.
    "SAML" for SAML providers, "Facebook" for Facebook login, "Google" for Google login, and "LoginWithAmazon" for
    Login with Amazon.
  - provider_details: The identity provider details, such as MetadataURL and MetadataFile.
EOF
  default     = null
}

variable "identity_provider_optionals_config" {
  type = list(object({
    name              = string
    attribute_mapping = optional(map(string), null)
    idp_identifiers   = optional(list(string), null)
  }))
  description = <<EOF
  List of identity provider configurations to create. The required arguments are described in the
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_identity_provider
These are:
  - name: Friendly identifier for the terraform resource to be created.
  - attribute_mapping: A mapping of identity provider attributes to standard and custom user pool attributes.
  - idp_identifiers: A list of identity provider identifiers.
EOF
  default     = null
}
