resource "aws_cognito_user_pool_domain" "this" {
  for_each        = local.domain_cfg_create
  domain          = each.value["domain"]
  user_pool_id    = each.value["user_pool_id"]
  certificate_arn = each.value["certificate_arn"]
}
