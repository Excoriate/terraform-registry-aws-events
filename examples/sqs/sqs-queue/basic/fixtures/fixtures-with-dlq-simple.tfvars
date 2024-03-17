is_enabled = true

tags = {
  Environment = "Development"
  Project     = "SQS Module Testing"
}

queue = {
  name                              = "my-application-queue"
  fifo_queue                        = true
  content_based_deduplication       = true
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 2048  # 2 KB
  delay_seconds                     = 10
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 600 # 10 minutes
}

dead_letter_queue = {
  name                              = "my-application-queue-dlq"
  fifo_queue                        = true
  content_based_deduplication       = true
  max_receive_count                 = 3
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 86400 # 1 day
  max_message_size                  = 2048  # 2 KB
  delay_seconds                     = 10
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 600 # 10 minutes
}
