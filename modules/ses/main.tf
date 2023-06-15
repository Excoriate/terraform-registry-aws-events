##########################################
# SES Domain Identity
##########################################
resource "aws_ses_domain_identity" "this" {
  for_each = local.ses_config_create
  domain   = each.value["domain"]
}
