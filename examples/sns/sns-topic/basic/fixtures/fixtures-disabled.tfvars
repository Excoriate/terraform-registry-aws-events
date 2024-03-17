is_enabled = false

tags = {
  "Environment" = "Test",
  "Project"     = "Recipe"
}

topic = {
  name                        = "my-application-standard-topic"
  display_name                = "My Application Alerts"
  policy                      = <<EOP
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudwatch.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:us-east-1:123456789012:my-application-standard-topic"
    }
  ]
}
EOP
  delivery_policy             = <<EOP
{
  "healthyRetryPolicy": {
    "numRetries": 3,
    "numNoDelayRetries": 0,
    "minDelayTarget": 10,
    "maxDelayTarget": 30,
    "numMinDelayRetries": 0,
    "numMaxDelayRetries": 2,
    "backoffFunction": "arithmetic"
  }
}
EOP
  fifo_topic                  = false
  content_based_deduplication = false
}
