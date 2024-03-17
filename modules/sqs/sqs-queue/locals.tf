locals {
  ###################################
  # Feature Flags ⛳️
  # ----------------------------------------------------
  #
  # These flags are used to enable or disable certain features.
  # 1. `is_queue_enabled` - Flag to enable or disable the SQS queue that's built-in to the module.
  # 2. `is_dlq_enabled` - Flag to enable or disable the Dead Letter Queue (DLQ) that's built-in to the module.
  #
  ###################################
  is_queue_enabled      = var.is_enabled && var.queue != null
  is_dlq_enabled        = var.is_enabled && var.dead_letter_queue != null
  is_fifo_queue_enabled = !local.is_queue_enabled ? false : var.queue.fifo_queue

  ###################################
  # Normalized & CLeaned Variables 🧹
  # ----------------------------------------------------
  #
  # These variables are used to normalize and clean the input variables.
  # 1. `queue_name` - The name of the queue. This is normalized to remove any leading or trailing whitespace.
  # 2. `queue_name_fifo` - The name of the FIFO queue. This is normalized to remove any leading or trailing whitespace.
  #
  ###################################
  queue_name      = !local.is_queue_enabled ? null : trimspace(var.queue.name)
  queue_name_fifo = !local.is_fifo_queue_enabled ? null : format("%s.fifo", local.queue_name)
}
