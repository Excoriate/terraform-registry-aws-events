resource "aws_cognito_user_pool_client" "this" {
  for_each     = local.user_pool_client_create
  name         = each.value["name"]
  user_pool_id = each.value["user_pool_id"]
  // OAuth configuration
  allowed_oauth_flows_user_pool_client = !local.is_oauth_config_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_flows_user_pool_client", null)
  allowed_oauth_flows                  = !local.is_oauth_config_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_flows", null)
  allowed_oauth_scopes                 = !local.is_oauth_config_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "allowed_oauth_scopes", null)
  callback_urls                        = !local.is_oauth_config_enabled ? null : lookup(local.oauth_config_create, each.key, null) == null ? null : lookup(local.oauth_config_create[each.key], "callback_urls", null)

  // Token configuration
  id_token_validity      = !local.is_token_config_enabled ? null : lookup(local.token_config_create, each.key, null) == null ? null : lookup(local.token_config_create[each.key], "id_token_validity", null)
  access_token_validity  = !local.is_token_config_enabled ? null : lookup(local.token_config_create, each.key, null) == null ? null : lookup(local.token_config_create[each.key], "access_token_validity", null)
  refresh_token_validity = !local.is_token_config_enabled ? null : lookup(local.token_config_create, each.key, null) == null ? null : lookup(local.token_config_create[each.key], "refresh_token_validity", null)

  dynamic "token_validity_units" {
    for_each = !local.is_token_config_enabled ? [] : lookup(local.token_config_create, each.key, null) == null ? [] : [lookup(local.token_config_create[each.key], "token_validity_units", null)]
    content {
      id_token      = lookup(token_validity_units.value, "id_token", null)
      access_token  = lookup(token_validity_units.value, "access_token", null)
      refresh_token = lookup(token_validity_units.value, "refresh_token", null)
    }
  }
}
