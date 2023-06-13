resource "aws_cognito_user_pool_client" "this" {
  for_each     = local.user_pool_client_create
  name         = each.value["name"]
  user_pool_id = each.value["user_pool_id"]
  // OAuth configuration
  allowed_oauth_flows_user_pool_client = !local.is_oauth_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_flows_user_pool_client", null)
  allowed_oauth_flows                  = !local.is_oauth_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_flows", null)
  allowed_oauth_scopes                 = !local.is_oauth_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_scopes", null)
  callback_urls                        = !local.is_oauth_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "callback_urls", null)

  // Token configuration
}
