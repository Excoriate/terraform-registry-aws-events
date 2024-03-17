resource "aws_sqs_queue_policy" "this" {
  for_each = local.is_policies_enabled ? { for idx, policy in var.queue_policies : idx => policy } : {}

  queue_url = aws_sqs_queue.this[0].id
  policy    = join("", [data.aws_iam_policy_document.this[each.key].json])
}

data "aws_iam_policy_document" "this" {
  for_each = local.is_policies_enabled ? { for idx, policy in var.queue_policies : idx => policy } : {}

  statement {
    actions   = lookup(each.value, "actions", [])
    resources = [aws_sqs_queue.this[0].arn]
    effect    = "Allow"

    principals {
      type        = lookup(each.value["principals"], "type", "AWS")
      identifiers = lookup(each.value["principals"], "identifiers", [])
    }

    dynamic "condition" {
      for_each = length(lookup(each.value, "conditions", [])) > 0 ? lookup(each.value, "conditions", []) : []

      content {
        test     = condition.value["test"]
        variable = condition.value["variable"]
        values   = condition.value["values"]
      }
    }
  }
}
