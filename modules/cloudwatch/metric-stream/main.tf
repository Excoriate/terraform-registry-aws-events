locals {
  validations = {
    is_deduplication_set_when_fifo_is_true         = !local.is_queue_enabled ? true : var.queue.deduplication_scope == null ? true : var.queue.deduplication_scope != "" && var.queue.fifo_queue == true ? true : false
    is_fifo_throughput_limit_set_when_fifo_is_true = !local.is_queue_enabled ? true : var.queue.fifo_throughput_limit == null ? true : var.queue.fifo_throughput_limit != "" && var.queue.fifo_queue == true ? true : false
    is_fifo_queue_name_ending_with_fifo            = !local.is_queue_enabled ? true : var.queue.fifo_queue == true ? length(regexall(".*\\.fifo$", local.queue_name_fifo)) > 0 : true
    is_dql_fifo_queue_name_ending_with_fifo        = !local.is_dlq_enabled ? true : var.dead_letter_queue.fifo_queue == true ? length(regexall(".*\\.fifo$", local.dlq_name_fifo)) > 0 : true
  }
}

resource "aws_sqs_queue" "this" {
  count = local.is_queue_enabled ? 1 : 0

  name                              = local.is_fifo_queue_enabled ? local.queue_name_fifo : local.queue_name
  visibility_timeout_seconds        = var.queue.visibility_timeout_seconds
  message_retention_seconds         = var.queue.message_retention_seconds
  max_message_size                  = var.queue.max_message_size
  delay_seconds                     = var.queue.delay_seconds
  receive_wait_time_seconds         = var.queue.receive_wait_time_seconds
  policy                            = var.queue.policy
  fifo_queue                        = var.queue.fifo_queue
  content_based_deduplication       = var.queue.content_based_deduplication
  kms_master_key_id                 = var.queue.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.queue.kms_data_key_reuse_period_seconds
  deduplication_scope               = var.queue.deduplication_scope
  fifo_throughput_limit             = var.queue.fifo_throughput_limit
  tags                              = var.tags

  ##########################################
  # Precondition checks 👀
  # ----------------------------------
  # These preconditions aims to tackle errors that appear on 'Apply' time, due to AWS API restrictions.
  # The idea is to prevent the user from applying the changes and getting an error, by checking if the options are set correctly.
  # If the options are not set correctly, the user will get an error on 'Plan' time, and will be able to fix it before applying the changes.
  #
  ##########################################

  lifecycle {
    precondition {
      condition     = local.validations.is_deduplication_set_when_fifo_is_true
      error_message = "The option deduplication_scope must be set when fifo_queue is true, otherwise it'll fail on 'Apply' due to AWS API restrictions."
    }

    precondition {
      condition     = local.validations.is_fifo_throughput_limit_set_when_fifo_is_true
      error_message = "The option fifo_throughput_limit must be set when fifo_queue is true, otherwise it'll fail on 'Apply' due to AWS API restrictions."
    }

    precondition {
      condition     = local.validations.is_fifo_queue_name_ending_with_fifo
      error_message = "The queue name must end with '.fifo' when fifo_queue is true."
    }
  }
}

resource "aws_sqs_queue" "dlq" {
  count = local.is_dlq_enabled ? 1 : 0

  name                              = local.is_fifo_queue_enabled ? local.dlq_name_fifo : local.dlq_name
  visibility_timeout_seconds        = var.dead_letter_queue.visibility_timeout_seconds
  message_retention_seconds         = var.dead_letter_queue.message_retention_seconds
  max_message_size                  = var.dead_letter_queue.max_message_size
  delay_seconds                     = var.dead_letter_queue.delay_seconds
  receive_wait_time_seconds         = var.dead_letter_queue.receive_wait_time_seconds
  policy                            = var.dead_letter_queue.policy
  fifo_queue                        = var.dead_letter_queue.fifo_queue
  content_based_deduplication       = var.dead_letter_queue.content_based_deduplication
  kms_master_key_id                 = var.dead_letter_queue.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.dead_letter_queue.kms_data_key_reuse_period_seconds
  deduplication_scope               = var.dead_letter_queue.deduplication_scope
  fifo_throughput_limit             = var.dead_letter_queue.fifo_throughput_limit
  tags                              = var.tags # Consider if DLQ tags need merging with main queue tags

  ##########################################
  # Precondition checks 👀
  # ----------------------------------
  # These preconditions aims to tackle errors that appear on 'Apply' time, due to AWS API restrictions.
  # The idea is to prevent the user from applying the changes and getting an error, by checking if the options are set correctly.
  # If the options are not set correctly, the user will get an error on 'Plan' time, and will be able to fix it before applying the changes.
  #
  ##########################################

  lifecycle {
    precondition {
      condition     = local.validations.is_deduplication_set_when_fifo_is_true
      error_message = "The option deduplication_scope must be set when fifo_queue is true, otherwise it'll fail on 'Apply' due to AWS API restrictions."
    }

    precondition {
      condition     = local.validations.is_fifo_throughput_limit_set_when_fifo_is_true
      error_message = "The option fifo_throughput_limit must be set when fifo_queue is true, otherwise it'll fail on 'Apply' due to AWS API restrictions."
    }

    precondition {
      condition     = local.validations.is_dql_fifo_queue_name_ending_with_fifo
      error_message = "The queue name must end with '.fifo' when fifo_queue is true."
    }
  }
}
