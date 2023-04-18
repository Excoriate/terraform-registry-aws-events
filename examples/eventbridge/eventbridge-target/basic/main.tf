module "main_module" {
  source             = "../../../../modules/eventbridge/eventbridge-target"
  is_enabled         = var.is_enabled
  rule_config        = var.rule_config
  aws_region         = var.aws_region
  rule_event_pattern = var.rule_event_pattern
}
