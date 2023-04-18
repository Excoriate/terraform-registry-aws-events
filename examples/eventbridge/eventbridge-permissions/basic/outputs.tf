output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "event_bridge_role_id" {
  value       = module.main_module.event_bridge_role_id
  description = "The ID of the IAM role for EventBridge."
}

output "event_bridge_role_name" {
  value       = module.main_module.event_bridge_role_name
  description = "The name of the IAM role for EventBridge."
}

output "event_bridge_role_arn" {
  value       = module.main_module.event_bridge_role_arn
  description = "The ARN of the IAM role for EventBridge."
}

output "event_bridge_policy" {
  value       = module.main_module.event_bridge_policy
  description = "The ARN of the IAM policy for EventBridge."
}

output "event_bridge_policy_doc" {
  value       = module.main_module.event_bridge_policy_doc
  description = "The IAM policy for EventBridge."
}
