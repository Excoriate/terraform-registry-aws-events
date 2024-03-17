module "main_module" {
  source     = "../../../../modules/sqs/sqs-queue"
  is_enabled = var.is_enabled
  queue      = var.queue
  tags       = var.tags
}
