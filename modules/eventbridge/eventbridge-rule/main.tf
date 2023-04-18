resource "aws_cloudwatch_event_rule" "this" {
  for_each            = local.rule_cfg_map
  name                = each.value["name"]
  description         = each.value["description"]
  event_pattern       = lookup({ for k, v in local.pattern_cfg_map : k => v if k == each.key }, each.key, null) == null ? null : lookup(local.pattern_cfg_map[each.key], "pattern_json_encoded")
  schedule_expression = each.value["schedule_expression"]
  event_bus_name      = each.value["event_bus_name"]
  role_arn            = each.value["is_default_role_to_be_used"] ? aws_iam_role.this[each.key].arn : each.value["role_arn"]
  tags                = var.tags
}
