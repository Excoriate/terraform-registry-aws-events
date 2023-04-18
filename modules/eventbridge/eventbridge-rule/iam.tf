data "aws_iam_policy_document" "assume_role" {
  for_each = { for k, v in local.rule_cfg_map : k => v if v["is_default_role_to_be_used"] == true }
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = distinct(concat(["events.amazonaws.com"], var.trusted_entities))
    }
  }
}

resource "aws_iam_role" "this" {
  for_each              = { for k, v in local.rule_cfg_map : k => v if v["is_default_role_to_be_used"] == true }
  description           = format("Default IAM Role for %s", each.key)
  path                  = "/"
  force_detach_policies = true
  permissions_boundary  = var.permissions_boundary
  assume_role_policy    = data.aws_iam_policy_document.assume_role[each.key].json

  tags = var.tags
}

/*
  * Permissions for AWS Lambda functions
*/
