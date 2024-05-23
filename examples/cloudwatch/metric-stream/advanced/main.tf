module "main_module" {
  source     = "../../../../modules/cloudwatch/metric-stream"
  is_enabled = var.is_enabled
  tags       = var.tags
  stream = {
    name          = "metric-stream-advanced"
    firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
    role_arn      = aws_iam_role.metric_stream_to_firehose.arn
    output_format = "json"
  }
  statistics_configurations = [
    {
      namespace             = "AWS/EC2"
      metric_name           = "CPUUtilization"
      additional_statistics = ["p95", "p99"]
      include_metrics = [
        {
          metric_name = "DiskReadOps"
          namespace   = "AWS/EC2"
        },
        {
          metric_name = "DiskWriteOps"
          namespace   = "AWS/EC2"
        }
      ]
    },
    {
      namespace             = "AWS/RDS"
      metric_name           = "CPUUtilization"
      additional_statistics = ["p90", "p99"]
      include_metrics = [
        {
          metric_name = "ReadIOPS"
          namespace   = "AWS/RDS"
        },
        {
          metric_name = "WriteIOPS"
          namespace   = "AWS/RDS"
        }
      ]
    }
  ]
  include_filters = [
    {
      namespace    = "AWS/EC2"
      metric_names = ["CPUUtilization", "DiskReadOps", "DiskWriteOps"]
    },
    {
      namespace    = "AWS/RDS"
      metric_names = ["CPUUtilization", "ReadIOPS", "WriteIOPS"]
    }
  ]
  #   exclude_filters = [
  #     {
  #       namespace    = "AWS/S3"
  #       metric_names = ["BucketSizeBytes", "NumberOfObjects"]
  #     },
  #     {
  #       namespace    = "AWS/ELB"
  #       metric_names = ["HealthyHostCount", "UnHealthyHostCount"]
  #     }
  #   ]
}

data "aws_iam_policy_document" "streams_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "metric_stream_to_firehose" {
  name               = "metric_stream_to_firehose_role"
  assume_role_policy = data.aws_iam_policy_document.streams_assume_role.json
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
data "aws_iam_policy_document" "metric_stream_to_firehose" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.s3_stream.arn]
  }
}
resource "aws_iam_role_policy" "metric_stream_to_firehose" {
  name   = "metric_stream_to_firehose_policy_advanced"
  role   = aws_iam_role.metric_stream_to_firehose.id
  policy = data.aws_iam_policy_document.metric_stream_to_firehose.json
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "metric-stream-test-bucket-${random_id.bucket_suffix.hex}"
}

data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "firehose_to_s3" {
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

data "aws_iam_policy_document" "firehose_to_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose_to_s3" {
  name   = "firehose_to_s3_policy_advanced"
  role   = aws_iam_role.firehose_to_s3.id
  policy = data.aws_iam_policy_document.firehose_to_s3.json
}

resource "aws_kinesis_firehose_delivery_stream" "s3_stream" {
  name        = "metric-stream-test-stream-${random_id.bucket_suffix.hex}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_to_s3.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}
