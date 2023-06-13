resource "aws_cognito_user_pool_client" "this" {
  for_each     = local.user_pool_client_create
  name         = each.value["name"]
  user_pool_id = each.value["user_pool_id"]
}
