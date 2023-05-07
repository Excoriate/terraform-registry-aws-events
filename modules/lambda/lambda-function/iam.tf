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
resource "aws_lambda_permission" "default_eventbridge" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_file"] && lookup(local.eventbridge_cfg, k, null) != null }
  statement_id  = format("AllowExecutionFromEventBridge-%s", each.key)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = lookup(local.eventbridge_cfg[each.key], "source_arn")
  qualifier     = lookup(local.eventbridge_cfg[each.key], "qualifier")
}

/*
  * -------------------------------
  * AWS Secrets manager
  * -------------------------------
*/
resource "aws_lambda_permission" "default_secrets_manager" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["enabled_from_file"] && lookup(local.secretsmanager_cfg, k, null) != null }
  statement_id  = format("AllowExecutionFromSecretsManager-%s", each.key)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default[each.key].function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = lookup(local.secretsmanager_cfg[each.key], "lookup_by_secret_name", false) ? data.aws_secretsmanager_secret.lookup_secret_by_name[each.key].arn : lookup(local.secretsmanager_cfg[each.key], "secret_arn")
  qualifier     = lookup(local.secretsmanager_cfg[each.key], "qualifier")
}

resource "aws_lambda_permission" "s3_existing_secrets_manager" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_file"] && lookup(local.secretsmanager_cfg, k, null) != null }
  statement_id  = format("AllowExecutionFromSecretsManager-%s", each.key)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.from_s3_existing[each.key].function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = lookup(local.secretsmanager_cfg[each.key], "lookup_by_secret_name", false) ? data.aws_secretsmanager_secret.lookup_secret_by_name[each.key].arn : lookup(local.secretsmanager_cfg[each.key], "secret_arn")
  qualifier     = lookup(local.secretsmanager_cfg[each.key], "qualifier")
}


/*
  * -------------------------------
  * Deployment bucket
  * -------------------------------
*/

/*
  * -------------------------------
  * Permissions to deploy the lambda
  * from ECR, when the lambda from-docker
  * option is set.
  * -------------------------------
*/
data "aws_iam_policy_document" "deploy_from_ecr" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_docker"] == true && lookup(local.lambda_docker_cfg, k, null) != null }

  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    resources = lookup(local.lambda_docker_cfg[each.key], "ecr_arn", null) == null ? ["*"] : [lookup(local.lambda_docker_cfg[each.key], "ecr_arn")]
  }
}

resource "aws_iam_policy" "deploy_from_ecr" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_docker"] == true && lookup(local.lambda_docker_cfg, k, null) != null }
  name     = format("deploy_from_ecr-%s", each.key)
  policy   = data.aws_iam_policy_document.deploy_from_ecr[each.key].json
}

resource "aws_iam_role_policy_attachment" "deploy_from_ecr" {
  for_each   = { for k, v in local.lambda_cfg : k => v if v["enabled_from_docker"] == true && lookup(local.lambda_docker_cfg, k, null) != null }
  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.deploy_from_ecr[each.key].arn
}
