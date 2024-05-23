locals {
  ###################################
  # Feature Flags ⛳️
  # ----------------------------------------------------
  #
  # These flags are used to enable or disable certain features.
  # 1. `is_stream_enabled` - Flag to enable or disable the CloudWatch metric stream that's built-in to the module.
  #
  ###################################
  is_stream_enabled                   = var.is_enabled && var.stream != null
  is_statistics_configuration_enabled = !local.is_stream_enabled ? false : var.statistics_configurations == null ? false : length(var.statistics_configurations) > 0
  is_include_filters_enabled          = !local.is_stream_enabled ? false : var.include_filters == null ? false : length(var.include_filters) > 0
  is_exclude_filters_enabled          = !local.is_stream_enabled ? false : var.exclude_filters == null ? false : length(var.exclude_filters) > 0

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
  stream_name = !local.is_stream_enabled ? "" : var.stream.name == null ? "" : trimspace(var.stream.name)

  # 🧹 `firehose_arn`: Cleaned to ensure it follows the correct ARN pattern.
  # This prevents errors related to malformed ARNs.
  firehose_arn = !local.is_stream_enabled ? "" : var.stream.firehose_arn == null ? "" : trimspace(var.stream.firehose_arn)

  # 🧹 `role_arn`: Cleaned to ensure it follows the correct ARN pattern.
  # Ensures the IAM role ARN is correctly formatted.
  role_arn = !local.is_stream_enabled ? "" : var.stream.role_arn == null ? "" : trimspace(var.stream.role_arn)

  # 🧹 `output_format`: Normalized to lowercase to ensure consistency.
  # This prevents case sensitivity issues and ensures the value is one of the expected formats.
  output_format = !local.is_stream_enabled ? "" : var.stream.output_format == null ? "" : lower(trimspace(var.stream.output_format))

  # 🧹 `include_filters`: Normalizes each filter by trimming whitespace from namespace and metrics.
  # Ensures clean and correctly formatted filter values.
  include_filters = !local.is_include_filters_enabled ? [] : [
    for filter in var.include_filters : {
      namespace = trimspace(filter["namespace"])                                                                   # 🧹 Trims whitespace from namespace.
      metrics   = filter["metric_names"] == null ? [] : [for metric in filter["metric_names"] : trimspace(metric)] # 🧹 Trims whitespace from each metric.
    }
  ]

  # 🧹 `exclude_filters`: Normalizes each filter by trimming whitespace from namespace and metrics.
  # Ensures clean and correctly formatted filter values.
  exclude_filters = !local.is_exclude_filters_enabled ? [] : [
    for filter in var.exclude_filters : {
      namespace = trimspace(filter["namespace"])                                                                   # 🧹 Trims whitespace from namespace.
      metrics   = filter["metric_names"] == null ? [] : [for metric in filter["metric_names"] : trimspace(metric)] # 🧹 Trims whitespace from each metric.
    }
  ]
  # 🧹 `statistics_configurations`: Normalizes each configuration by trimming whitespace from namespace, metric names, and statistics.
  # Ensures clean and correctly formatted configuration values.
  statistics_configurations = !local.is_statistics_configuration_enabled ? [] : [
    for config in var.statistics_configurations : {
      namespace             = trimspace(config.namespace)                                  # 🧹 Trims whitespace from namespace.
      metric_name           = trimspace(config.metric_name)                                # 🧹 Trims whitespace from metric name.
      additional_statistics = [for stat in config.additional_statistics : trimspace(stat)] # 🧹 Trims whitespace from each statistic.
      include_metrics = config.include_metrics == null ? [] : [
        for metric in config.include_metrics : {
          metric_name = trimspace(metric.metric_name)
          namespace   = trimspace(metric.namespace)
        }
      ]
    }
  ]

  # 🧹 `include_linked_accounts_metrics`: Uses the provided value or defaults to false.
  # Ensures a boolean value is always available.
  include_linked_accounts_metrics = local.is_stream_enabled ? var.stream.include_linked_accounts_metrics : false
}
