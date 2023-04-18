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
variable "lambda_config" {
  type = list(object({
    name = string
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
  EOF
}

variable "lambda_observability_config" {
  type = list(object({
    name                   = string
    logs_enabled           = optional(bool, false)
    logs_retention_in_days = optional(number, 0)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
  EOF
}

variable "lambda_permissions_config" {
  type = list(object({
    name                 = string
    permissions_boundary = optional(string, null)
    trusted_principals   = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_custom_policies_config" {
  type = list(object({
    name        = string
    policy_arns = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
EOF
}
