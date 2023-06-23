##########################################
# SES Notification
##########################################
resource "aws_sns_topic" "notification_topic_ooo" {
  for_each     = { for k, v in local.ses_notification_config_create : k => v if v["is_sns_topic_ooo_to_create"] }
  name         = format("%s-sns-notification", each.value["name"])
  display_name = format("%s-sns-notification", each.value["name"])
  policy       = data.aws_iam_policy_document.notification_topic_policy[each.key].json
}

data "aws_iam_policy_document" "notification_topic_policy" {
  for_each = { for k, v in local.ses_notification_config_create : k => v if v["is_sns_topic_ooo_to_create"] }
  statement {
    actions = [
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:Receive",
      "SNS:AddPermission",
      "SNS:Subscribe",
    ]

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_ses_identity_notification_topic" "notification_ooo" {
  for_each                 = { for k, v in local.ses_notification_config_create : k => v if v["is_sns_topic_ooo_to_create"] }
  topic_arn                = aws_sns_topic.notification_topic_ooo[each.key].arn
  notification_type        = each.value["notification_type"]
  identity                 = aws_ses_domain_identity.this[each.key].domain
  include_original_headers = each.value["include_original_headers"]
}

resource "aws_ses_identity_notification_topic" "this" {
  for_each                 = { for k, v in local.ses_notification_config_create : k => v if !v["is_sns_topic_ooo_to_create"] }
  topic_arn                = each.value["topic_arn"]
  notification_type        = each.value["notification_type"]
  identity                 = aws_ses_domain_identity.this[each.key].domain
  include_original_headers = each.value["include_original_headers"]
}
