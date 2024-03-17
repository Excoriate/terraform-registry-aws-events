is_enabled = true

tags = {
  "Environment" = "Testing",
  "Project"     = "Recipe-SNS"
}

topic = {
  name                        = "my-application-topic"
  display_name                = "My Application Notifications"
  policy                      = <<-EOP
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudwatch.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:us-east-1:123456789012:my-application-topic"
    }
  ]
}
EOP
  delivery_policy             = <<-EOP
{
  "healthyRetryPolicy": {
    "numRetries": 4,
    "minDelayTarget": 20,
    "maxDelayTarget": 20,
    "backoffFunction": "arithmetic"
  }
}
EOP
  kms_master_key_id           = "alias/aws/sns"
  fifo_topic                  = false
  content_based_deduplication = false
}

topic_publisher_permissions = {
  allowed_services = ["s3.amazonaws.com", "lambda.amazonaws.com"]
  #  allowed_iam_arns = ["arn:aws:iam::123456789012:role/SNSPublishRole"]
}
