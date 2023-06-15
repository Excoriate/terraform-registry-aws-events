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
variable "ses_config" {
  type = object({
    name   = string
    domain = optional(string, null)
  })
  description = <<EOF
  A list of SES configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - domain: The domain to associate with the SES configuration. E.g: example.com, if it's not passed,
the SES configuration will set the 'domain' with the 'name' attribute value. E.g: example.com
EOF
}
