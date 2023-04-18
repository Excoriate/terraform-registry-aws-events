locals {
  aws_region_to_deploy = var.aws_region

  is_module_enabled                      = var.is_enabled
  is_role_config_enabled                 = !local.is_module_enabled ? false : var.role_config != null
  is_permissions_enabled                 = !local.is_module_enabled ? false : var.lambda_permissions_config != null
  is_attachment_of_policies_docs_enabled = !local.is_module_enabled ? false : var.attach_policies == null ? false : lookup(var.attach_policies, "policy_json_docs", null) == null ? false : var.attach_policies.policy_json_docs != null
  is_attachment_of_policies_arns_enabled = !local.is_module_enabled ? false : var.attach_policies == null ? false : lookup(var.attach_policies, "policy_arns", null) == null ? false : length(var.attach_policies.policy_arns) > 0

  // 1. Role configuration.
  role_cfg_normalised = !local.is_role_config_enabled ? [] : [
    {
      name                  = lower(trimspace(var.role_config.name))
      path                  = "/"
      description           = format("IAM Role for EventBridge - Role for %s", var.role_config.name)
      permissions_boundary  = lookup(var.role_config, "permissions_boundary", null)
      force_detach_policies = lookup(var.role_config, "force_detach_policies", false)
      trusted_entities = length(var.role_config.trusted_entities) == 0 ? [] : [
        for trusted_entity in var.role_config.trusted_entities : {
          type = lower(trimspace(trusted_entity.type))
          identifiers = length(trusted_entity.identifiers) == 0 ? [] : [
            for identifier in trusted_entity.identifiers : lower(trimspace(identifier))
          ]
        }
      ]
    }
  ]

  role_cfg = {
    for role in local.role_cfg_normalised : role["name"] => role
  }

  /*
   * Configuration for [lambda] specific permissions
  */
  lambda_permissions = !local.is_permissions_enabled ? [] : [
    {
      name       = lower(trimspace(var.lambda_permissions_config.name))
      is_enabled = lookup(var.lambda_permissions_config, "enable_lambda", false)
      lambda_arns = length(var.lambda_permissions_config.lambda_arns) == 0 ? [] : [
        for lambda_arn in var.lambda_permissions_config.lambda_arns : lower(trimspace(lambda_arn))
      ]
    }
  ]

  lambda_permissions_cfg = {
    for p in local.lambda_permissions : p["name"] => p if p["is_enabled"]
  }

  /*
   * Configuration for passing custom policies.
   - Current supported approach: passing a list of policy ARNs, and/or a list of maps containing policy name and policy document.
  */
  attachment_docs = !local.is_attachment_of_policies_docs_enabled ? [] : [
    for policy in var.attach_policies.policy_json_docs : {
      policy_name = lower(trimspace(policy.policy_name))
      role_name   = lookup(var.attach_policies, "role_name")
      policy_doc  = jsonencode(policy.policy_doc)
    }
  ]

  attachment_docs_cfg = {
    for p in local.attachment_docs : p["policy_name"] => p
  }

  attachment_arns = !local.is_attachment_of_policies_arns_enabled ? [] : [
    for p in var.attach_policies.policy_arns : {
      policy_name = lower(trimspace(p.policy_name))
      policy_arn  = lower(trimspace(p.policy_arn))
      role_name   = lookup(var.attach_policies, "role_name")
    }
  ]

  attachment_arns_cfg = {
    for p in local.attachment_arns : p["policy_name"] => p
  }
}
