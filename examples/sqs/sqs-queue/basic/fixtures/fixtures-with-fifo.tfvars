is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "test-queue" # Name must end with '.fifo' for FIFO queues
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 10240 # 10 KB
  delay_seconds                     = 5
  receive_wait_time_seconds         = 10
  fifo_queue                        = true # Must be true for FIFO queues
  content_based_deduplication       = true # Enable or disable based on your use case
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 86400               # 24 hours
  deduplication_scope               = "messageGroup"      # FIFO queues support 'messageGroup' or 'queue' as valid values
  fifo_throughput_limit             = "perMessageGroupId" # 'perQueue' or 'perMessageGroupId' are valid
}
