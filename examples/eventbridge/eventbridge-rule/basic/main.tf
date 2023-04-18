module "main_module" {
  source               = "../../../../modules/eventbridge/eventbridge-rule"
  is_enabled           = var.is_enabled
  rule_config          = var.rule_config
  aws_region           = var.aws_region
  rule_event_pattern   = var.rule_event_pattern
  trusted_entities     = var.trusted_entities
  permissions_boundary = var.permissions_boundary
}
