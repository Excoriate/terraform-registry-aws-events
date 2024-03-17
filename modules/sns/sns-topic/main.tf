resource "aws_sns_topic" "this" {
  count = local.is_topic_enabled ? 1 : 0

  name                        = local.topic_name
  display_name                = local.display_name
  kms_master_key_id           = var.topic.kms_master_key_id
  policy                      = var.topic.policy
  fifo_topic                  = var.topic.fifo_topic
  content_based_deduplication = var.topic.content_based_deduplication
  tags                        = var.tags
}

resource "aws_sns_topic_policy" "this" {
  count = local.is_sns_topic_policy_custom_enabled || local.is_topic_publisher_policy_enabled ? 1 : 0

  arn    = join("", aws_sns_topic.this.*.arn)
  policy = local.is_sns_topic_policy_custom_enabled ? var.sns_topic_policy_custom : data.aws_iam_policy_document.sns_topic_policy[0].json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count = local.is_topic_publisher_policy_enabled ? 1 : 0

  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.this[0].arn]
    effect    = "Allow"

    principals {
      type        = "Service"
      identifiers = local.is_topic_publisher_policy_allowed_services_enabled ? var.topic_publisher_permissions.allowed_services : []
    }

    principals {
      type        = "AWS"
      identifiers = local.is_topic_publisher_policy_allowed_iam_arns_enabled ? var.topic_publisher_permissions.allowed_iam_arns : []
    }
  }
}
