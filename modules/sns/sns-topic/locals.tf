locals {
  ###################################
  # Feature Flags ⛳️
  # ----------------------------------------------------
  #
  # These flags are used to enable or disable certain features.
  # 1. `is_topic_enabled` - Flag to enable or disable the SNS topic.
  # 2. `is_topic_publisher_policy_enabled` - Flag to enable or disable the SNS topic publisher policy that's built-in to the module.
  # 3. `is_topic_publisher_policy_allowed_services_enabled` - Flag to enable or disable the SNS topic publisher policy's allowed services.
  # 4. `is_topic_publisher_policy_allowed_iam_arns_enabled` - Flag to enable or disable the SNS topic publisher policy's allowed IAM ARNs.
  #
  ###################################
  is_topic_enabled                                   = var.is_enabled && var.topic != null
  is_sns_topic_policy_custom_enabled                 = !local.is_topic_enabled ? false : var.sns_topic_policy_custom != null
  is_topic_publisher_policy_enabled                  = !local.is_topic_enabled ? false : local.is_sns_topic_policy_custom_enabled != null ? false : var.topic_publisher_permissions == null ? false : lookup(var.topic_publisher_permissions, "allowed_services", null) == null && lookup(var.topic_publisher_permissions, "allowed_iam_arns", null) == null ? false : true
  is_topic_publisher_policy_allowed_services_enabled = !local.is_topic_publisher_policy_enabled ? false : length(lookup(var.topic_publisher_permissions, "allowed_services", [])) > 0
  is_topic_publisher_policy_allowed_iam_arns_enabled = !local.is_topic_publisher_policy_enabled ? false : length(lookup(var.topic_publisher_permissions, "allowed_iam_arns", [])) > 0
  is_fifo_topic_enabled                              = !local.is_topic_enabled ? false : var.topic.fifo_topic

  ###################################
  # Normalized & CLeaned Variables 🧹
  # ----------------------------------------------------
  #
  # These variables are used to normalize and clean the input variables.
  # 1. `topic_name` - The normalized topic name. If it's a 'fifo' topic, then it will have the '.fifo' suffix.
  # 2. `display_name` - The normalized display name. If it's not provided, then it will be the same as the topic name. Also,
  # dots are illegal in display names and for .fifo topics required as part of the name (AWS SNS by design).
  #
  ###################################
  topic_name   = !local.is_topic_enabled ? null : local.is_fifo_topic_enabled ? format("%s.fifo", trimspace(var.topic.name)) : trimspace(var.topic.name)
  display_name = !local.is_topic_enabled ? null : var.topic.display_name != null ? replace(var.topic.display_name, "/\\./g", "-") : local.is_fifo_topic_enabled ? format("%s-fifo", trimspace(var.topic.name)) : trimspace(var.topic.name)
}
