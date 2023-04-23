resource "aws_s3_object" "lambda_zip" {
  for_each = { for k, v in local.s3_deploy_cfg : k => v if v["enable_deployment_from_bucket"] }
  bucket   = each.value["s3_bucket"]
  key      = each.value["s3_key"]
  source   = each.value["filename"] != null ? each.value["filename"] : lookup(local.archive_cfg, each.key, null) != null ? lookup(local.archive_cfg[each.key], "source_file", null) != null ? data.archive_file.source_file[each.key].output_path : null : data.archive_file.source_file[each.key].output_path
}
