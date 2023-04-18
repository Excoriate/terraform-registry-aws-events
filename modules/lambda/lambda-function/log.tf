data "aws_iam_policy_document" "cloudwatch_logs_group_policy_doc" {
  for_each = local.observability_cfg

  statement {
    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:DeleteLogStream",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
    ]

    resources = [
      aws_cloudwatch_log_group.this[each.key].arn
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_logs_group_policy" {
  for_each    = local.observability_cfg
  name        = "cloudwatch_logs_group_policy_${each.key}"
  description = "Policy for CloudWatch Logs Group"
  policy      = data.aws_iam_policy_document.cloudwatch_logs_group_policy_doc[each.key].json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_group_policy_attachment" {
  for_each   = local.observability_cfg
  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.cloudwatch_logs_group_policy[each.key].arn
}

resource "aws_cloudwatch_log_group" "this" {
  for_each          = local.observability_cfg
  name              = each.value["log_group_name"]
  retention_in_days = each.value["logs_retention_in_days"]
  tags              = var.tags
}
