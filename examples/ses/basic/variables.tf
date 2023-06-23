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
    name                    = string
    domain                  = optional(string, null)
    create_domain_mail_from = optional(bool, false)
    behavior_on_mx_failure  = optional(string, "UseDefaultValue")
    emails = optional(list(object({
      address = string
      enabled = optional(bool, true)
    })), [])
  })
  description = <<EOF
  A list of SES configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - domain: The domain to associate with the SES configuration. E.g: example.com, if it's not passed,
the SES configuration will set the 'domain' with the 'name' attribute value. E.g: example.com
  - create_domain_mail_from: Whether to create a domain mail from or not. Default: false
  - behavior_on_mx_failure: The action that you want Amazon SES to take if it cannot successfully read the required MX record when you send an email. Default: UseDefaultValue
  - emails: A list of emails to create. Each item in the list must have the following attributes:
    - address: The email address to create.
    - enabled: Whether the email is enabled or not. Default: true
EOF
}

variable "ses_verification_config" {
  type = object({
    name    = string
    ttl     = optional(number, 600)
    enabled = optional(bool, true)
  })
  description = <<EOF
  A list of SES verification configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - ttl: The TTL of the verification record in seconds. Default: 600
  - enabled: Whether the verification record is enabled or not. Default: true
EOF
  default     = null
}

variable "ses_validation_config" {
  type = object({
    name                   = string
    enable_spf_validation  = optional(bool, false)
    enable_dkim_validation = optional(bool, false)
  })
  description = <<EOF
  A list of SES validation configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - enable_spf_validation: Whether to enable SPF validation or not. Default: false
  - enable_dkim_validation: Whether to enable DKIM validation or not. Default: false
EOF
  default     = null
}

variable "ses_notification_config" {
  type = object({
    name                     = string
    topic_arn                = optional(string, null)
    notification_type        = optional(string, "Bounce")
    include_original_headers = optional(bool, false)
  })
  description = <<EOF
  A list of SES notification configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - topic_arn: The ARN of the SNS topic to notify when Amazon SES receives an email on behalf of one or more of the email addresses associated with the configuration set. If this attribute is not passed, the SES
will create a new SNS topic and associate it with the configuration set.
  - notification_type: The type of notifications that you want to receive. Default: Bounce
  - include_original_headers: Whether to include original headers in the notifications or not. Default: false
EOF
  default     = null
}

variable "ses_template_config" {
  type = list(object({
    name    = string
    subject = string
    html    = optional(string, null)
    text    = optional(string, null)
  }))
  description = <<EOF
  A list of SES template configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - subject: The subject line of the email.
  - html: The HTML body of the email. If this attribute is not passed, the SES will not create a HTML template.
  - text: The text body of the email. If this attribute is not passed, the SES will not create a text template.
EOF
  default     = null
}

variable "ses_event_destination_config" {
  type = list(object({
    name           = string
    enabled        = optional(bool, true)
    matching_types = optional(list(string), ["reject", "bounce", "renderingFailure"])
    cloudwatch_destination = optional(object({
      default_value  = string
      dimension_name = string
      value_source   = optional(string, "messageTag")
    }), null)
    kinesis_destination = optional(object({
      role_arn   = string
      stream_arn = string
    }), null)
    sns_destination = optional(object({
      topic_arn = optional(string, null) // if it's not set, it'll create a new topic
    }), null)
  }))
  description = <<EOF
  A list of SES event destination configurations to create. Each item in the list must have the following attributes:
  - name: A terraform identifier used in the context of resource configuration only, not in the actual SES configuration.
  - enabled: Whether the event destination is enabled or not. Default: true
  - matching_types: A list of event types to send to the event destination. Default: ["reject", "bounce", "renderingFailure"]
  - cloudwatch_destination: A cloudwatch destination configuration. If this attribute is not passed, the SES will not create a cloudwatch destination.
  - kinesis_destination: A kinesis destination configuration. If this attribute is not passed, the SES will not create a kinesis destination.
  - sns_destination: A sns destination configuration. If this attribute is not passed, the SES will not create a sns destination.
EOF
  default     = null
}
