aws_region = "us-east-1"
is_enabled = true

role_config = {
  name                  = "eventbridge-role-1"
  force_detach_policies = true
}

attach_policies = {
  role_name = "eventbridge-role-1"
  policy_arns = [
    {
      policy_name = "eventbridge-policy-1"
      policy_arn  = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
    }
  ]
}
