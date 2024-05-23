module "main_module" {
  source                = "../../../../modules/cloudwatch/metric-stream"
  is_enabled            = var.is_enabled
  tags                  = var.tags
  stream                = var.stream
  additional_statistics = var.additional_statistics
}
