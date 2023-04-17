variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "task_config" {
  type = list(object({
    // General settings
    name                           = string
    family                         = optional(string, null)
    container_definition_from_json = optional(string, null)
    container_definition_from_file = optional(string, null)
    type                           = optional(string, "FARGATE")
    network_mode                   = optional(string, "awsvpc")
    // Capacity
    cpu    = optional(number, 256)
    memory = optional(number, 512)
    // proxy_configuration
    proxy_configuration = optional(object({
      type           = string
      container_name = string
      properties = optional(list(object({
        name  = string
        value = string
      })), [])
    }), null)
    // Ephemeral storage
    ephemeral_storage = optional(number, null)
    task_placement_constraints = optional(list(object({
      type       = string
      expression = string
    })), null)
    service_placement_constraints = optional(list(object({
      type       = string
      expression = string
    })), null)
    runtime_platforms                = optional(list(map(string)), null)
    manage_task_outside_of_terraform = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for each task definition.
The currently supported attributes are:
- name: The name of the task definition.
- family: The family of the task definition. If not provided, it'll use the name.
- container_definition_from_json: The JSON string that contains the container definition.
- container_definition_from_file: The path to the file that contains the container definition.
- type: The type of the task definition. Valid values are: EC2, FARGATE. Default: FARGATE.
- network_mode: The network mode of the task definition. Valid values are: awsvpc, bridge, host, none. Default: awsvpc.
- cpu: The number of CPU units to reserve for the container. Default: 256.
- memory: The amount of memory (in MiB) to allow the container to use. Default: 512.
- task_role_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.
- execution_role_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the task role.
- proxy_configuration: The proxy configuration details for the App Mesh proxy.
  EOF
}

variable "task_permissions_config" {
  type = list(object({
    name                         = string
    task_role_arn                = optional(string, null)
    execution_role_arn           = optional(string, null)
    permissions_boundary         = optional(string, null)
    disable_built_in_permissions = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for each task permissions.
The currently supported attributes are:
- name: The name of the task definition.
- task_role_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.
- execution_role_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the task role.
  EOF
}

variable "scenario_simple" {
  type    = bool
  default = false
}

variable "scenario_simple_passed_roles" {
  type    = bool
  default = false
}

variable "scenario_multiple" {
  type    = bool
  default = false
}

variable "scenario_tf_unmanaged" {
  type    = bool
  default = false
}
