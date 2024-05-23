module "main_module" {
  source                    = "../../../../modules/cloudwatch/metric-stream"
  is_enabled                = var.is_enabled
  tags                      = var.tags
  stream                    = var.stream
  statistics_configurations = var.statistics_configurations
  include_filters           = var.include_filters
  exclude_filters           = var.exclude_filters
}
