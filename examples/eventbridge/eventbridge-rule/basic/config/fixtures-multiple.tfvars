aws_region = "us-east-1"
is_enabled = true

rule_config = [
  {
    name                = "rule1"
    description         = "rule1 description"
    schedule_expression = "rate(5 minutes)"
  },
  {
    name                = "rule2"
    description         = "rule2 description"
    schedule_expression = "rate(10 minutes)"
  },
  {
    name        = "rule3"
    description = "rule3 description"
  },
]
