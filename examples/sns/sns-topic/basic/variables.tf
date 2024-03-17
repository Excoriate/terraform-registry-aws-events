variable "is_enabled" {
  type        = bool
  description = <<-DESC
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
  DESC
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

###################################
# Specific for this module
###################################
variable "topic" {
  type = object({
    name                        = string
    display_name                = optional(string)
    policy                      = optional(string)
    delivery_policy             = optional(string)
    kms_master_key_id           = optional(string)
    fifo_topic                  = optional(bool, false)
    content_based_deduplication = optional(bool, false) # Relevant only if fifo_topic is true
  })
  default     = null
  description = <<-DESC
    An object representing AWS SNS topics to be created, supporting both standard and FIFO topics. Each object allows you to specify:

    - 'name': The name of the SNS topic, unique within an AWS account. For FIFO topics, the name must end with '.fifo'.
    - 'display_name' (Optional): The display name for the SNS topic, used in the "From" field for emails sent from this topic.
    - 'policy' (Optional): A JSON-formatted string defining who can access the SNS topic.
    - 'delivery_policy' (Optional): A JSON-formatted string controlling how SNS retries message delivery for this topic.
    - 'kms_master_key_id' (Optional): The ID of a custom KMS key for message encryption. If not specified, AWS uses the default KMS key.
    - 'tags' (Optional): A map of tags for resource identification and management. Defaults to an empty map.
    - 'fifo_topic' (Optional, Defaults to false): Specifies if the SNS topic is a FIFO topic.
    - 'content_based_deduplication' (Optional, Defaults to false): Enables content-based deduplication for FIFO topics.

    Example:
    ```
    [
      {
        name                        = "my-application-topic"
        display_name                = "My Application"
        policy                      = "{\"Version\": \"2012-10-17\",\"Statement\": [{\"Effect\": \"Allow\",\"Principal\": {\"AWS\": \"*\"},\"Action\": \"SNS:Publish\",\"Resource\": \"arn:aws:sns:us-east-1:123456789012:my-application-topic\"}]}"
        delivery_policy             = "{\"healthyRetryPolicy\":{\"numRetries\":10, \"numNoDelayRetries\": 0, \"minDelayTarget\": 20, \"maxDelayTarget\": 20, \"numMinDelayRetries\": 0, \"numMaxDelayRetries\": 0, \"backoffFunction\": \"linear\"}}"
        kms_master_key_id           = "alias/aws/sns"
        fifo_topic                  = false
        content_based_deduplication = false
      }
    ]
    ```
  DESC
}

variable "topic_publisher_permissions" {
  type = object({
    allowed_services = optional(list(string), [])
    allowed_iam_arns = optional(list(string), [])
  })
  default     = null
  description = <<-DESC
    An object representing the permissions to publish to the SNS topic. Each object in the list allows you to specify:

    - 'allowed_services' (Optional): A list of AWS service principal names that are allowed to publish messages to the topic. For example, ['s3.amazonaws.com', 'lambda.amazonaws.com'].
    - 'allowed_iam_arns' (Optional): A list of IAM role ARNs that are allowed to publish messages to the topic. For example, ['arn:aws:iam::123456789012:role/MyRole'].

    Example:
    ```
      {
        allowed_services = ["s3.amazonaws.com", "lambda.amazonaws.com"]
        allowed_iam_arns = ["arn:aws:iam::123456789012:role/MyRole"]
      }
    ```
  DESC
}

variable "sns_topic_policy_custom" {
  type        = string
  default     = null
  description = <<-DESC
    A custom JSON-formatted policy string used to control access to the SNS topic. If not specified, a default policy
    based on the 'topic_publisher_permissions' variable will be used. When specified, this policy overrides
    any automatically generated policy, giving full control over who can publish to the SNS topic.

    Note: Ensure the policy JSON is correctly formatted and valid. Incorrect policies can result in the SNS topic
    being inaccessible or not functioning as intended.
  DESC
}
