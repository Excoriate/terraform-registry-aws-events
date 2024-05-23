resource "aws_cloudwatch_metric_stream" "this" {
  for_each = local.is_stream_enabled ? { "create" = true } : {}

  name          = local.stream_name
  firehose_arn  = local.firehose_arn
  role_arn      = local.role_arn
  output_format = local.output_format

  ##########################################
  # Precondition checks 👀
  # ----------------------------------
  # These preconditions aim to tackle errors that appear at 'Apply' time, due to AWS API restrictions.
  # The idea is to prevent the user from applying the changes and getting an error, by checking if the options are set correctly.
  # If the options are not set correctly, the user will get an error at 'Plan' time and will be able to fix it before applying the changes.
  #
  ##########################################

  lifecycle {
    precondition {
      condition     = contains(["json", "opentelemetry1.0", "opentelemetry0.7"], local.output_format)
      error_message = "Invalid 'output_format'. Must be one of 'json', 'opentelemetry1.0', or 'opentelemetry0.7'."
    }

    precondition {
      condition     = can(regex("^arn:aws:firehose:[a-z0-9-]+:\\d{12}:deliverystream/[a-zA-Z0-9_-]+$", local.firehose_arn))
      error_message = "Invalid 'firehose_arn'. Must be a valid Kinesis Firehose ARN."
    }

    precondition {
      condition     = can(regex("^arn:aws:iam::\\d{12}:role/[a-zA-Z0-9+=,.@_-]+$", local.role_arn))
      error_message = "Invalid 'role_arn'. Must be a valid IAM role ARN."
    }

    precondition {
      condition     = length(local.stream_name) <= 255 && length(local.stream_name) > 0
      error_message = "Invalid 'name'. Must be between 1 and 255 characters."
    }
  }

  dynamic "include_filter" {
    for_each = local.include_filters
    content {
      namespace    = include_filter.value["namespace"]
      metric_names = include_filter.value["metrics"]
    }
  }

  dynamic "exclude_filter" {
    for_each = local.exclude_filters
    content {
      namespace    = exclude_filter.value["namespace"]
      metric_names = exclude_filter.value["metrics"]
    }
  }

  include_linked_accounts_metrics = local.include_linked_accounts_metrics

  dynamic "statistics_configuration" {
    for_each = local.additional_statistics
    content {
      additional_statistics = statistics_configuration.value["statistics"]
      include_metric {
        metric_name = statistics_configuration.value["metric_names"][0]
        namespace   = statistics_configuration.value["namespace"]
      }
    }
  }

  tags = merge(var.tags, lookup(var.stream, "tags", {}))
}
