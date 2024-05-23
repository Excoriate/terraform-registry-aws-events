module "main_module" {
  source            = "../../../../modules/sqs/sqs-queue"
  is_enabled        = var.is_enabled
  queue             = var.queue
  dead_letter_queue = var.dead_letter_queue
  queue_policies    = var.queue_policies
  tags              = var.tags
}
