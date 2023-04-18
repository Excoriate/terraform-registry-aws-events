/*
  * ------------------------------------
  * Permissions passed through existing IAM
  * policies
  * ------------------------------------
*/
resource "aws_iam_policy" "custom_policy" {
  for_each    = local.attachment_docs_cfg
  name        = each.value["policy_name"]
  description = format("Policy for %s", each.value["policy_name"])
  policy      = each.value["policy_doc"]
}

resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  for_each   = local.attachment_docs_cfg
  role       = aws_iam_role.this[each.value["role_name"]].name
  policy_arn = aws_iam_policy.custom_policy[each.key].arn
}

/*
  * ------------------------------------
  * Attach passed policy ARNs
  * ------------------------------------
*/
resource "aws_iam_role_policy_attachment" "custom_policy_attachment_arns" {
  for_each   = local.attachment_arns_cfg
  role       = aws_iam_role.this[each.value["role_name"]].name
  policy_arn = each.value["policy_arn"]
}


/*
  * ------------------------------------
  * Permissions for AWS Lambda functions
  * ------------------------------------
*/
data "aws_iam_policy_document" "lambda_policy_doc" {
  for_each = { for k, v in local.lambda_permissions_cfg : k => v if v["is_enabled"] }
  statement {
    sid       = "LambdaAccess"
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = each.value["lambda_arns"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  for_each    = { for k, v in local.lambda_permissions_cfg : k => v if v["is_enabled"] }
  name        = "lambda-policy-${each.key}"
  description = "Lambda policy for ${each.key}"
  policy      = data.aws_iam_policy_document.lambda_policy_doc[each.key].json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  for_each   = { for k, v in local.lambda_permissions_cfg : k => v if v["is_enabled"] }
  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.lambda_policy[each.key].arn
}
