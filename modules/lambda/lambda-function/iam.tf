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

/*
  * -------------------------------
  * Eventbridge
  * -------------------------------
*/
resource "aws_lambda_permission" "eventbridge" {
  for_each      = local.eventbridge_cfg
  statement_id  = format("AllowExecutionFromEventBridge-%s", each.key)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = each.value["source_arn"]
  qualifier     = each.value["qualifier"]
}

/*
  * -------------------------------
  * AWS Secrets manager
  * -------------------------------
*/
resource "aws_lambda_permission" "secretsmanager" {
  for_each      = local.secretsmanager_cfg
  statement_id  = format("AllowExecutionFromSecretsManager-%s", each.key)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default[each.key].function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = each.value["source_arn"]
  qualifier     = each.value["qualifier"]
}

/*
  * -------------------------------
  * Deployment bucket
  * -------------------------------
*/
data "aws_iam_policy_document" "deployment_bucket" {
  for_each = local.s3_deploy_cfg
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]
    resources = [
      lookup(data.aws_s3_bucket.this[each.key], "arn", null),
      "${lookup(data.aws_s3_bucket.this[each.key], "arn", null)}/*"
    ]
  }
}
