is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "test-queue"
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 10240 # 10 KB
  delay_seconds                     = 5
  receive_wait_time_seconds         = 10
  fifo_queue                        = false
  content_based_deduplication       = false
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 86400 # 24 hours
  #  deduplication_scope               = "queue"
  #  fifo_throughput_limit = "perQueue"
}
