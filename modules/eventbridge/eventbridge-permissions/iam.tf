data "aws_iam_policy_document" "assume_role" {
  for_each = local.role_cfg
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = distinct(concat(["events.amazonaws.com"], each.value["trusted_entities"]))
    }
  }
}

resource "aws_iam_role" "this" {
  for_each              = local.role_cfg
  description           = each.value["description"]
  path                  = each.value["path"]
  force_detach_policies = each.value["force_detach_policies"]
  permissions_boundary  = each.value["permissions_boundary"]
  assume_role_policy    = data.aws_iam_policy_document.assume_role[each.key].json

  tags = var.tags
}
