variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

###################################
# Specific for this module
###################################
#variable "secrets" {
#  type = list(object({
#    name            = string
#    description     = optional(string)
#    value           = string
#    key_id          = optional(string) # KMS key ID for encryption. If not specified, AWS uses the default key.
#    overwrite       = optional(bool)
#    tier            = optional(string) # Standard, Advanced, or Intelligent-Tiering.
#    allowed_pattern = optional(string)
#    ignore_changes  = optional(bool, false)
#  }))
#  default     = null
#  description = <<-DESC
#    A list of objects representing AWS SSM parameters of type SecureString for securely storing secrets.
#    Each object in the list allows you to specify:
#
#    - 'name': The name of the SSM parameter (must comply with SSM parameter name constraints. More info: https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-parameter-name-constraints.html).
#    - 'description' (Optional): A description of the SSM parameter.
#    - 'value': The value of the parameter to be stored securely.
#    - 'key_id' (Optional): The KMS key ID to use for encrypting the parameter value. If not specified, AWS uses the default KMS key.
#    - 'overwrite' (Optional): Whether to overwrite an existing parameter of the same name. Default is false.
#    - 'tier' (Optional): The parameter tier. Valid values are Standard, Advanced, or Intelligent-Tiering. Default is Standard.
#    - 'allowed_pattern' (Optional): A regex pattern to validate the parameter value.
#    - 'ignore_changes' (Optional): A boolean flag to ignore changes to the parameter value. Default is false.
#
#    Note: Since these parameters are for secrets, the 'type' is implicitly SecureString and does not need to be specified.
#
#    Example:
#    ```
#    [
#      {
#        name        = "/prod/db/password"
#        description = "Production database password"
#        value       = "secret-password"
#        key_id      = "alias/aws/ssm" # Optional; if not specified, the default AWS KMS key is used.
#        overwrite   = true
#        tier        = "Standard"
#        allowed_pattern = "^[a-zA-Z0-9]*$"
#      }
#    ]
#    ```
#  DESC
#}
