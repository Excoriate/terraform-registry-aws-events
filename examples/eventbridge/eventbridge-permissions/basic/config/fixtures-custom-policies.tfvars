aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

attach_policies = {
  role_name = "eventbridge-role-1"
  policy_json_docs = [
    {
      policy_name = "eventbridge-policy-1"
      policy_doc = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "events:PutEvents",
            ]
            Effect   = "Allow"
            Resource = ["*"]
          },
        ]
      }
    },
    {
      policy_name = "eventbridge-policy-2"
      policy_doc = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "events:PutRule",
              "events:PutTargets",
              "events:DescribeRule",
              "events:RemoveTargets",
              "events:DeleteRule",
            ]
            Effect   = "Allow"
            Resource = ["*"]
          },
        ]
      }
    }
  ]
}
