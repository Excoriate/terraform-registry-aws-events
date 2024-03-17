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
variable "queue" {
  type = object({
    name                              = string
    visibility_timeout_seconds        = optional(number, 30)
    message_retention_seconds         = optional(number, 345600)
    max_message_size                  = optional(number, 262144)
    delay_seconds                     = optional(number, 0)
    receive_wait_time_seconds         = optional(number, 0)
    policy                            = optional(string)
    redrive_policy                    = optional(string)
    fifo_queue                        = optional(bool, false)
    content_based_deduplication       = optional(bool, false) # Relevant only if fifo_queue is true
    kms_master_key_id                 = optional(string)
    kms_data_key_reuse_period_seconds = optional(number, 300)
    deduplication_scope               = optional(string, "queue")    # Valid values are "queue" and "messageGroup"
    fifo_throughput_limit             = optional(string, "perQueue") # Valid values are "perQueue" and "perMessageGroupId"
  })
  default     = null
  description = <<-DESC
    An object representing an AWS SQS queue to be created, supporting both standard and FIFO queues. Each object allows you to specify:

    - 'name': The name of the SQS queue, unique within an AWS account. For FIFO queues, the name must end with '.fifo'.
    - 'visibility_timeout_seconds' (Optional, Default 30): The visibility timeout for the queue. An integer from 0 to 43200 (12 hours).
    - 'message_retention_seconds' (Optional, Default 345600): The number of seconds SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days).
    - 'max_message_size' (Optional, Default 262144): The limit of how many bytes a message can contain before SQS rejects it. From 1024 bytes (1 KiB) to 262144 bytes (256 KiB).
    - 'delay_seconds' (Optional, Default 0): The queue's default delay for messages in seconds. An integer from 0 to 900 (15 minutes).
    - 'receive_wait_time_seconds' (Optional, Default 0): The duration (in seconds) for which the call waits for a message to arrive in the queue before returning.
    - 'policy' (Optional): The JSON policy for the queue.
    - 'redrive_policy' (Optional): The JSON policy to specify the dead-letter queue for this SQS queue.
    - 'fifo_queue' (Optional, Defaults to false): Specifies if the SQS queue is a FIFO queue.
    - 'content_based_deduplication' (Optional, Defaults to false): Enables content-based deduplication for FIFO queues.
    - 'kms_master_key_id' (Optional): The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK.
    - 'kms_data_key_reuse_period_seconds' (Optional, Default 300): The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling KMS again.
    - 'tags' (Optional, Defaults to an empty map): A map of tags to assign to the queue for resource management.
    - 'deduplication_scope' (Optional, Default "queue"): Specifies the deduplication scope. Valid values are "queue" and "messageGroup".
    - 'fifo_throughput_limit' (Optional, Default "perQueue"): Specifies the throughput limit. Valid values are "perQueue" and "perMessageGroupId".

    Example:
    ```
    {
      name                              = "my-application-queue.fifo"
      fifo_queue                        = true
      content_based_deduplication       = true
      visibility_timeout_seconds        = 45
      message_retention_seconds         = 86400
      max_message_size                  = 2048
      delay_seconds                     = 10
      receive_wait_time_seconds         = 20
      kms_master_key_id                 = "alias/aws/sqs"
      kms_data_key_reuse_period_seconds = 600
    }
    ```
  DESC
}

variable "dead_letter_queue" {
  type = object({
    name                        = optional(string)
    max_receive_count           = optional(number, 5)
    visibility_timeout_seconds  = optional(number, 30)
    message_retention_seconds   = optional(number, 345600)
    max_message_size            = optional(number, 262144)
    delay_seconds               = optional(number, 0)
    receive_wait_time_seconds   = optional(number, 0)
    policy                      = optional(string)
    fifo_queue                  = optional(bool, false)
    content_based_deduplication = optional(bool, false) # Relevant only if fifo_queue is true
  })
  default     = null
  description = <<-DESC
    An optional object representing an AWS SQS dead letter queue to be created alongside the main SQS queue.
    Specify only if you want to create a dead letter queue. Each object allows you to specify:

    - 'name' (Optional): The name of the SQS dead letter queue. If not provided, a name is generated based on the main queue's name with a '-dlq' suffix.
    - 'max_receive_count' (Optional, Default 5): The number of times a message is delivered to the source queue before being moved to the dead letter queue.
    - 'visibility_timeout_seconds', 'message_retention_seconds', 'max_message_size', 'delay_seconds', 'receive_wait_time_seconds', 'policy', 'fifo_queue', 'content_based_deduplication', 'tags': Same as described for the main queue variable.

    Example:
    ```
    {
      name                      = "my-application-queue-dlq.fifo"
      fifo_queue                = true
      content_based_deduplication = true
      max_receive_count         = 3
    }
    ```
  DESC
}
