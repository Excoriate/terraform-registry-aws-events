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
    name                           = string
    function_name                  = optional(string, null)
    description                    = optional(string, null)
    publish                        = optional(bool, false)
    filename                       = optional(string, null)
    architectures                  = optional(list(string), ["x86_64"])
    memory_size                    = optional(number, 128)
    handler                        = string
    reserved_concurrent_executions = optional(number, -1)
    #    provision_concurrency =optional(number, null)
    runtime                                  = optional(string, "nodejs18.x")
    layers                                   = optional(list(string), [])
    package_type                             = optional(string, "Zip")
    timeout                                  = optional(number, 3)
    enable_update_function_on_archive_change = optional(bool, false)
    // Describe the types of lambda deployments that are supported by this module.
    deployment_type = optional(object({
      from_file                            = optional(bool, false)
      from_docker                          = optional(bool, false)
      from_archive                         = optional(bool, false)
      from_s3_existing_file                = optional(bool, false)
      from_s3_new_file                     = optional(bool, false)
      from_s3_managed_bucket_existing_file = optional(bool, false)
      from_s3_managed_bucket_new_file      = optional(bool, false)
    }), null)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
  EOF
}

variable "lambda_archive_config" {
  type = list(object({
    name           = string
    function_name  = optional(string, null)
    source_dir     = optional(string, null)
    source_file    = optional(string, null)
    package_name   = optional(string, "lambda.zip")
    excluded_files = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_image_config" {
  type = list(object({
    name          = string
    function_name = optional(string, null)
    ecr_arn       = optional(string, null)
    image_uri     = string
    image_config = optional(list(object({
      command           = optional(list(string), [])
      entry_point       = optional(list(string), [])
      working_directory = optional(string, null)
    })), [])
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_s3_from_bucket_config" {
  type = list(object({
    name            = string
    s3_bucket       = string
    source_zip_file = optional(string, null)
    source_config = optional(object({
      source_file = optional(string, null)
      source_dir  = optional(string, null)
    }), null)
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_observability_config" {
  type = list(object({
    name                   = string
    logs_enabled           = optional(bool, false)
    logs_retention_in_days = optional(number, 0)
    tracing_enabled        = optional(bool, false)
    tracing_mode           = optional(string, "PassThrough")
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

variable "lambda_enable_eventbridge" {
  type = list(object({
    name       = string
    source_arn = string
    qualifier  = optional(string, null)
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_enable_secrets_manager" {
  type = list(object({
    name       = string
    secret_arn = string
    qualifier  = optional(string, null)
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_host_config" {
  type = list(object({
    name                  = string
    environment_variables = optional(map(string), {})
    ephemeral_storage     = optional(number, null)
    file_system_config = optional(list(object({
      local_mount_path = string
      arn              = string
    })), [])
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_network_config" {
  type = list(object({
    name               = string
    security_group_ids = optional(list(string), [])
    subnet_ids         = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
EOF
}

variable "lambda_alias_config" {
  type = list(object({
    name             = string
    alias_name       = string
    description      = optional(string, null)
    function_version = optional(string, null)
    routing_config = optional(list(object({
      additional_version_weights = optional(map(number), {})
    })), [])
  }))
  default     = null
  description = <<EOF
EOF
}
