locals {
  ###################################
  # Feature Flags ⛳️
  # ----------------------------------------------------
  #
  # These flags are used to enable or disable certain features.
  # 1. `is_stream_enabled` - Flag to enable or disable the CloudWatch metric stream that's built-in to the module.
  #
  ###################################
  is_stream_enabled = var.is_enabled && var.stream != null

  ###################################
  # Normalized & Cleaned Variables 🧹
  # ----------------------------------------------------
  #
  # These variables are used to normalize and clean the input variables.
  # 1. `stream_name` - The name of the metric stream. This is normalized to remove any leading or trailing whitespace.
  # 2. `firehose_arn` - The ARN of the Kinesis Firehose delivery stream, cleaned to ensure it follows the correct pattern.
  # 3. `role_arn` - The ARN of the IAM role, cleaned to ensure it follows the correct pattern.
  # 4. `output_format` - The output format for the stream, normalized to lowercase.
  #
  ###################################
  # 🧹 `stream_name`: Normalized to remove any leading or trailing whitespace.
  # Ensures the name is clean and formatted correctly.
  stream_name = local.is_stream_enabled && var.stream.name != null ? trimspace(var.stream.name) : ""

  # 🧹 `firehose_arn`: Cleaned to ensure it follows the correct ARN pattern.
  # This prevents errors related to malformed ARNs.
  firehose_arn = local.is_stream_enabled && var.stream.firehose_arn != null ? trimspace(var.stream.firehose_arn) : ""

  # 🧹 `role_arn`: Cleaned to ensure it follows the correct ARN pattern.
  # Ensures the IAM role ARN is correctly formatted.
  role_arn = local.is_stream_enabled && var.stream.role_arn != null ? trimspace(var.stream.role_arn) : ""

  # 🧹 `output_format`: Normalized to lowercase to ensure consistency.
  # This prevents case sensitivity issues and ensures the value is one of the expected formats.
  output_format = local.is_stream_enabled && var.stream.output_format != null ? lower(trimspace(var.stream.output_format)) : ""

  # 🧹 `include_filters`: Normalizes each filter by trimming whitespace from namespace and metrics.
  # Ensures clean and correctly formatted filter values.
  include_filters = local.is_stream_enabled && var.stream.include_filters != null ? [
    for filter in var.stream.include_filters : {
      namespace = trimspace(filter.namespace)                                                      # 🧹 Trims whitespace from namespace.
      metrics   = filter.metrics != null ? [for metric in filter.metrics : trimspace(metric)] : [] # 🧹 Trims whitespace from each metric.
    }
  ] : []

  # 🧹 `exclude_filters`: Normalizes each filter by trimming whitespace from namespace and metrics.
  # Ensures clean and correctly formatted filter values.
  exclude_filters = local.is_stream_enabled && var.stream.exclude_filters != null ? [
    for filter in var.stream.exclude_filters : {
      namespace = trimspace(filter.namespace)                                                      # 🧹 Trims whitespace from namespace.
      metrics   = filter.metrics != null ? [for metric in filter.metrics : trimspace(metric)] : [] # 🧹 Trims whitespace from each metric.
    }
  ] : []

  # 🧹 `statistics_configurations`: Normalizes each configuration by trimming whitespace from namespace, metric names, and statistics.
  # Ensures clean and correctly formatted configuration values.
  statistics_configurations = local.is_stream_enabled && var.stream.statistics_configurations != null ? [
    for config in var.stream.statistics_configurations : {
      namespace    = trimspace(config.namespace)                         # 🧹 Trims whitespace from namespace.
      metric_names = [for name in config.metric_names : trimspace(name)] # 🧹 Trims whitespace from each metric name.
      statistics   = [for stat in config.statistics : trimspace(stat)]   # 🧹 Trims whitespace from each statistic.
    }
  ] : []

  # 🧹 `include_linked_accounts_metrics`: Uses the provided value or defaults to false.
  # Ensures a boolean value is always available.
  include_linked_accounts_metrics = local.is_stream_enabled ? var.stream.include_linked_accounts_metrics : false
}
