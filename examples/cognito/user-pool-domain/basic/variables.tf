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
variable "user_pool_domain_config" {
  type = list(object({
    name            = string
    domain          = string
    user_pool_id    = string
    certificate_arn = optional(string, null)
  }))
  description = <<EOF
  List of objects containing the configuration for the user pool domain.
  name: The name of the domain.
  domain: The domain string.
  user_pool_id: The user pool ID.
  certificate_arn: The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain.
For more information see https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain.html
EOF
  default     = null
}
