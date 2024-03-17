is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Integration"
}

queue = {
  name                              = "simple-queue-example-with-pol"
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400
  max_message_size                  = 2048
  delay_seconds                     = 5
  receive_wait_time_seconds         = 10
  fifo_queue                        = false
  content_based_deduplication       = false
  kms_master_key_id                 = null
  kms_data_key_reuse_period_seconds = null
  deduplication_scope               = null
  fifo_throughput_limit             = null
}

queue_policies = [
  {
    actions    = ["sqs:SendMessage", "sqs:ReceiveMessage"]
    principals = { type = "AWS", identifiers = ["*"] }
    conditions = []
  },
  {
    actions    = ["sqs:DeleteMessage", "sqs:GetQueueAttributes"]
    principals = { type = "AWS", identifiers = ["*"] }
    conditions = [
      {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["true"]
      }
    ]
  }
]
