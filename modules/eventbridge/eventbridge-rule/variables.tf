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
    name                = string
    is_enabled          = optional(bool, true)
    description         = optional(string, null)
    event_bus_name      = optional(string, null)
    schedule_expression = optional(string, null)
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
