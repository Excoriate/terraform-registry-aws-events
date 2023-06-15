data "aws_route53_zone" "this" {
  for_each = local.ses_verification_config_create
  name     = each.value["domain"]
}
