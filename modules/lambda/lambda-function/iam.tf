data "aws_iam_policy_document" "assume_role" {
  for_each = local.permissions_cfg
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    // If the trusted entities are set.
    dynamic "principals" {
      for_each = each.value["trusted_entities"]
      content {
        type        = principals.value["type"]
        identifiers = principals.value["identifiers"]
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "custom_policies_attachment" {
  for_each   = { for policy in local.custom_policies_cfg : "${policy["name"]}-${policy["policy_arn"]}" => policy }
  role       = aws_iam_role.this[each.value["name"]].name
  policy_arn = each.value["policy_arn"]
}

resource "aws_iam_role" "this" {
  for_each              = local.permissions_cfg
  description           = format("Role for %s", each.key)
  path                  = "/"
  force_detach_policies = each.value["force_detach_policies"]
  permissions_boundary  = each.value["permissions_boundary"]
  assume_role_policy    = data.aws_iam_policy_document.assume_role[each.key].json

  tags = var.tags
}
