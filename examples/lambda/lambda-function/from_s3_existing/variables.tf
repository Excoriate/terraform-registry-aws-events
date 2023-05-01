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
      from_file                 = optional(bool, false)
      from_docker               = optional(bool, false)
      from_archive              = optional(bool, false)
      from_s3_existing_file     = optional(bool, false)
      from_s3_existing_new_file = optional(bool, false)
      full_managed              = optional(bool, false)
    }), null)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- description: The description of the lambda function.
- publish: This boolean flag can be used to request AWS Lambda to create the Lambda function and publish a version as an atomic operation.
- filename: The path to the function's deployment package within the local filesystem. If defined, The s3_bucket and s3_key attributes will be ignored.
- architectures: A list of supported architectures for the function. Valid values are x86_64 and arm64.
- memory_size : The amount of memory, in MB, that is allocated to your Lambda function.
- handler: The function entrypoint in your code.
- reserved_concurrent_executions: The amount of reserved concurrent executions for this lambda function.
- runtime: The identifier of the function's runtime.
- layers: A list of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function.
- package_type: The type of deployment package. Valid values are Zip and Image.
- timeout: The amount of time your Lambda Function has to run in seconds.
- enable_update_function_on_archive_change: This boolean flag can be used to enable/disable the update of the lambda function when the archive changes.
- deployment_type: Describe the types of lambda deployments that are supported by this module.
  - from_file: This boolean flag can be used to enable/disable the deployment of the lambda function from a file.
  - from_docker: This boolean flag can be used to enable/disable the deployment of the lambda function from a docker image.
  - from_archive: This boolean flag can be used to enable/disable the deployment of the lambda function from an archive.
  - from_s3_existing_file: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.
  - from_s3_existing_new_file: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.
  - full_managed: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.
It's important to mention that the deployment types are mutually exclusive, so only one of them can be true.
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
 A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- source_dir: The path to the function's source code directory within the local filesystem.
- source_file: The path to the function's source code file within the local filesystem.
- package_name: The name of the deployment package.
- excluded_files: A list of files to be excluded from the deployment package.
EOF
}

variable "lambda_image_config" {
  type = list(object({
    name          = string
    function_name = optional(string, null)
    image_uri     = string
    ecr_arn       = optional(string, null)
    image_config = optional(list(object({
      command           = optional(list(string), [])
      entry_point       = optional(list(string), [])
      working_directory = optional(string, null)
    })), [])
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- image_uri: The URI of a container image in the Amazon ECR registry.
- ecr_arn: The ARN of the Amazon ECR registry that contains the image.
- image_config: The configuration of the container image.
  - command: The command that is passed to the container.
  - entry_point: The entry point that is passed to the container.
  - working_directory: The working directory that is passed to the container.
EOF
}

variable "lambda_s3_from_existing_config" {
  type = list(object({
    name                   = string
    function_name          = optional(string, null)
    s3_bucket              = string
    s3_key                 = string
    s3_object_version      = optional(string, null)
    ignore_version_changes = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- s3_bucket: The name of the bucket where the zip file containing the source code of the lambda function is located.
- s3_key: The path of the zip file containing the source code of the lambda function.
- s3_object_version: The version of the zip file containing the source code of the lambda function.
- ignore_version_changes: This boolean flag can be used to enable/disable the update of the lambda function when the
version of the zip file changes.
EOF
}

variable "lambda_s3_from_existing_new_file_config" {
  type = list(object({
    name                   = string
    function_name          = optional(string, null)
    s3_bucket              = string
    source_zip_file        = optional(string, null)
    compress_from_file     = optional(string, null)
    compress_from_dir      = optional(string, null)
    ignore_version_changes = optional(bool, false)
    excluded_files         = optional(list(string), [])
  }))
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- s3_bucket: The name of the bucket where the zip file containing the source code of the lambda function is located.
- source_zip_file: The path of the zip file containing the source code of the lambda function.
- compress_from_file: The path of the file to be compressed.
- compress_from_dir: The path of the directory to be compressed.
- ignore_version_changes: This boolean flag can be used to enable/disable the update of the lambda function when the
version of the zip file changes.
- excluded_files: A list of files to be excluded from the deployment package.
EOF
  default     = null
}

variable "lambda_full_managed_config" {
  type = list(object({
    name                   = string
    function_name          = optional(string, null)
    source_zip_file        = optional(string, null)
    compress_from_file     = optional(string, null)
    compress_from_dir      = optional(string, null)
    ignore_version_changes = optional(bool, false)
    excluded_files         = optional(list(string), [])
  }))
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- function_name: The name of the lambda function. If not passed, the 'name' attribute will be used.
- source_zip_file: The path of the zip file containing the source code of the lambda function.
- compress_from_file: The path of the file to be compressed.
- compress_from_dir: The path of the directory to be compressed.
- ignore_version_changes: This boolean flag can be used to enable/disable the update of the lambda function when the
version of the zip file changes.
- excluded_files: A list of files to be excluded from the deployment package.
EOF
  default     = null
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
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- logs_enabled: A boolean flag that can be used to enable/disable the logging of the lambda function.
- logs_retention_in_days: The number of days to retain the logs of the lambda function.
- tracing_enabled: A boolean flag that can be used to enable/disable the tracing of the lambda function.
- tracing_mode: The tracing mode of the lambda function. The supported values are 'Active' and 'PassThrough'.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- permissions_boundary: The permissions boundary to be applied to the lambda function.
- trusted_principals: A list of trusted principals to be applied to the lambda function.
EOF
}

variable "lambda_custom_policies_config" {
  type = list(object({
    name        = string
    policy_arns = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- policy_arns: A list of policy ARNs to be attached to the lambda function.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- source_arn: The ARN of the event source.
- qualifier: The qualifier of the lambda function.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- secret_arn: The ARN of the secret.
- qualifier: The qualifier of the lambda function.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- environment_variables: A map of environment variables to be applied to the lambda function.
- ephemeral_storage: The amount of ephemeral storage to be applied to the lambda function.
- file_system_config: A list of file system configurations to be applied to the lambda function.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- security_group_ids: A list of security group IDs to be applied to the lambda function.
- subnet_ids: A list of subnet IDs to be applied to the lambda function.
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
  A list of objects that contains the configuration for AWS Lambda function
The currently supported attributes are:
- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'
isn't passed, it will be used as the function name.
- alias_name: The name of the alias.
- description: The description of the alias.
- function_version: The function version of the alias.
- routing_config: A list of routing configurations to be applied to the alias.
EOF
}
