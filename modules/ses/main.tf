##########################################
# SES Domain Identity
##########################################
resource "aws_ses_domain_identity" "this" {
  for_each = local.ses_config_create
  domain   = each.value["domain"]
}

##########################################
# SES Verification
##########################################
resource "aws_route53_record" "this" {
  for_each = local.ses_verification_config_create
  zone_id  = data.aws_route53_zone.this[each.key].zone_id
  name     = each.value["domain"]
  type     = "TXT"
  ttl      = each.value["ttl"]
  records  = [aws_ses_domain_identity.this[each.key].verification_token]

  depends_on = [
    data.aws_route53_zone.this
  ]
}

resource "aws_ses_domain_identity_verification" "this" {
  for_each = local.ses_verification_config_create
  domain   = each.value["domain"]

  depends_on = [
    aws_route53_record.this
  ]
}
