##########################################
# SES Domain Identity
##########################################
resource "aws_ses_domain_identity" "this" {
  for_each = local.ses_config_create
  domain   = each.value["domain"]
}

##########################################
# MAIL from domain
##########################################
resource "aws_ses_domain_mail_from" "this" {
  for_each               = { for k, v in local.ses_config_create : k => v if v["create_domain_mail_from"] }
  domain                 = aws_ses_domain_identity.this[each.key].domain
  mail_from_domain       = format("bounce.%s", aws_ses_domain_identity.this[each.key].domain)
  behavior_on_mx_failure = each.value["behavior_on_mx_failure"]
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

##########################################
# SES Validations (MX, SPF)
##########################################
// SPF checks
resource "aws_route53_record" "spf_txt" {
  for_each = { for k, v in local.ses_validation_config_create : k => v if v["enable_spf_validation"] }
  zone_id  = data.aws_route53_zone.this[each.key].zone_id
  name     = aws_ses_domain_mail_from.this[each.key].mail_from_domain
  type     = "TXT"
  ttl      = 600
  records  = ["v=spf1 include:amazonses.com -all"]
}

// MX record required for validating an mail_from_domain
resource "aws_route53_record" "mail_from_mx" {
  for_each = { for k, v in local.ses_config_create : k => v if v["create_domain_mail_from"] }
  zone_id  = data.aws_route53_zone.this[each.key].zone_id
  name     = aws_ses_domain_mail_from.this[each.key].mail_from_domain
  type     = "MX"
  ttl      = 600
  records  = ["10 feedback-smtp.${data.aws_region.this.name}.amazonses.com"]
}

##########################################
# SES DKIM
##########################################
resource "aws_ses_domain_dkim" "this" {
  for_each = { for k, v in local.ses_validation_config_create : k => v if v["enable_dkim_validation"] }
  domain   = aws_ses_domain_identity.this[each.key].domain
}

// x3 DKIM tokens required to be CNAME records, for domain authentication.
resource "aws_route53_record" "dkim_cname" {
  count   = length(keys({ for k, v in local.ses_validation_config_create : k => v if v["enable_dkim_validation"] })) == 0 ? 0 : 3
  zone_id = [for k, v in local.ses_validation_config_create : data.aws_route53_zone.this[k].zone_id][0]
  name    = format("%s._domainkey", [for k, v in local.ses_validation_config_create : aws_ses_domain_dkim.this[k].dkim_tokens][0][count.index])
  type    = "CNAME"
  ttl     = "600"
  records = [format("%s.dkim.amazonses.com", [for k, v in local.ses_validation_config_create : aws_ses_domain_dkim.this[k].dkim_tokens][0][count.index])]
}

##########################################
# SES Emails
##########################################
resource "aws_ses_email_identity" "this" {
  for_each = local.ses_emails_identities_config
  email    = each.value["full_address"]
}
