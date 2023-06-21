data "aws_route53_zone" "this" {
  for_each = local.ses_config_create
  name     = each.value["domain"]
}


data "aws_region" "this" {}
