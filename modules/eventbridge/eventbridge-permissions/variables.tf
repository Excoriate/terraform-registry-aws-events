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
variable "role_config" {
  type = object({
    // General settings
    name                  = string
    permissions_boundary  = optional(string, null)
    force_detach_policies = optional(bool, false)
    trusted_entities      = optional(list(string), [])
  })
  default     = null
  description = <<EOF
  This object configures an IAM role that can be used for an 'Eventbridge' rule. The current supported
attributes are:
- name: The name of the role
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the role
- force_detach_policies: Specifies to force detaching any policies the role has before destroying it. Defaults to false
- trusted_entities: A list of AWS account IDs (without hyphens) or AWS Organizations entity IDs (such as 'o-EXAMPLE') that are associated with the role
EOF
}

variable "lambda_permissions_config" {
  type = object({
    name          = string
    enable_lambda = optional(bool, false)
    lambda_arns   = optional(list(string), [])
  })
  default     = null
  description = <<EOF
      This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported
attributes are:
- name: The name of the role
- enable_lambda_permissions: Specifies to attach the 'AWSLambdaBasicExecutionRole' policy to the role. Defaults to false
- lambda_arns: The ARN of the AWS Lambda function
EOF
}

variable "attach_policies" {
  type = object({
    role_name = string
    policy_json_docs = optional(list(object({
      policy_name = string
      policy_doc = object({
        Version = string
        Statement = list(object({
          Sid      = optional(string, null)
          Effect   = string
          Action   = list(string)
          Resource = list(string)
        }))
      })
    })), [])
    policy_arns = optional(list(object({
      policy_name = string
      policy_arn  = string
    })), [])
  })
  description = <<EOF
      This object configures the permissions for the IAM role that can be used for an 'Eventbridge' rule and a AWS Lambda function. The current supported
attributes are:
- name: The name of the role
- policy_json_docs: A list of JSON documents that describe the policy
- policy_arns: A list of ARNs of IAM policies to attach to the role
EOF
}
