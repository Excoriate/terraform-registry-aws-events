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
variable "user_pool_client_config" {
  type = list(object({
    name         = string
    user_pool_id = string
  }))
  description = <<EOF
  Configuration for the user pool client. For more information, see the following link:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client
This configuration supports multiple user pool clients.
EOF
}
