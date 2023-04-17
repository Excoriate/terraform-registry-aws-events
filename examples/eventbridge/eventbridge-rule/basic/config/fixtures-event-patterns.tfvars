aws_region = "us-east-1"
is_enabled = true

rule_config = [
  {
    name                = "rule1"
    description         = "rule1 description"
    schedule_expression = "rate(5 minutes)"
  }
]

rule_event_pattern = [
  {
    name = "rule1"
    source = [
      "aws.health"
    ],
    detail-type = [
      "AWS Health Event"
    ],
    detail = {
      service = [
        "EC2"
      ],
      eventTypeCategory = [
        "issue"
      ]
    }
  }
]
