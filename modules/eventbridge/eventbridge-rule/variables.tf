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
variable "rule_config" {
  type = list(object({
    // General settings
    name                 = string
    is_enabled           = optional(bool, true)
    description          = optional(string, null)
    event_bus_name       = optional(string, null)
    schedule_expression  = optional(string, null)
    role_arn             = optional(string, null)
    disable_default_role = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for each rule.
 The following keys are supported:
  - name: (Required) The name of the rule.
  - is_enabled: (Optional) Indicates whether the rule is enabled or disabled.
  - description: (Optional) A description of the rule.
  - event_bus_name: (Optional) The name of the event bus associated with the rule.
  - schedule_expression: (Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).
  - role_arn: (Optional) The Amazon Resource Name (ARN) of the IAM role associated with the rule.
  - disable_default_role: (Optional) Indicates whether the rule is managed by AWS or created by the customer.
  EOF
}

variable "rule_event_pattern" {
  type = list(object({
    name        = string
    rule_name   = optional(string, null)
    source      = optional(list(string), null)
    account     = optional(list(string), null)
    region      = optional(list(string), null)
    detail-type = optional(list(string), null)
    resources   = optional(list(string), null)
    detail      = optional(map(any), {})
  }))

  default     = null
  description = <<EOF
  The event pattern of the rule.
  EOF
}

variable "trusted_entities" {
  type        = list(string)
  default     = []
  description = <<EOF
  A list of AWS account IDs, or * to specify all accounts. This is used to determine which other AWS accounts can put events to this account's default event bus.
  EOF
}

variable "permissions_boundary" {
  type        = string
  default     = null
  description = <<EOF
  The ARN of the policy that is used to set the permissions boundary for the role that is created for the event bus.
  EOF
}
