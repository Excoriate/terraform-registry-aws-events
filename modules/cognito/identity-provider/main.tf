resource "aws_cognito_identity_provider" "this" {
  for_each         = local.identity_provider_cfg_create
  user_pool_id     = each.value["user_pool_id"]
  provider_name    = each.value["provider_name"]
  provider_type    = each.value["provider_type"]
  provider_details = each.value["provider_details"]

  // Optional arguments passed
  attribute_mapping = !local.is_identity_provider_optional_cfg_enabled ? null : lookup(local.identity_provider_optionals_cfg_create, each.key, null) == null ? null : lookup(local.identity_provider_optionals_cfg_create[each.key], "attribute_mapping")
  idp_identifiers   = !local.is_identity_provider_optional_cfg_enabled ? null : lookup(local.identity_provider_optionals_cfg_create, each.key, null) == null ? null : lookup(local.identity_provider_optionals_cfg_create[each.key], "idp_identifiers")
}
