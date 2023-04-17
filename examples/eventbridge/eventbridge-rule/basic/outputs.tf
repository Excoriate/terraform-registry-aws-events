output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "event_rule_id" {
  value       = module.main_module.event_rule_id
  description = "The ID of the CloudWatch Event Rule."
}

output "event_rule_arn" {
  value       = module.main_module.event_rule_arn
  description = "The ARN of the CloudWatch Event Rule."
}

output "event_rule_name" {
  value       = module.main_module.event_rule_name
  description = "The name of the CloudWatch Event Rule."
}

output "event_rule_description" {
  value       = module.main_module.event_rule_description
  description = "The description of the CloudWatch Event Rule."
}

output "event_rule_event_pattern" {
  value       = module.main_module.event_rule_event_pattern
  description = "The event pattern of the CloudWatch Event Rule."
}
