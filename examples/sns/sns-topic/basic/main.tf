module "main_module" {
  source                      = "../../../../modules/sns/sns-topic"
  is_enabled                  = var.is_enabled
  topic                       = var.topic
  topic_publisher_permissions = var.topic_publisher_permissions
  sns_topic_policy_custom     = var.sns_topic_policy_custom
  tags                        = var.tags
}
