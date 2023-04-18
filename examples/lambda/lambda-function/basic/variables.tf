variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

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
