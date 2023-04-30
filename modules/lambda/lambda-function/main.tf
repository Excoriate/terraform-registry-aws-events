resource "aws_lambda_function" "default" {
  for_each                       = { for k, v in local.lambda_cfg : k => v if v["enabled_from_file"] && !v["enabled_from_archive"] && !v["enabled_from_docker"] && !v["enabled_from_s3_existing_file"] && !v["enabled_from_s3_existing_new_file"] && !v["enabled_from_s3_managed_bucket_existing_file"] && !v["enabled_from_s3_managed_bucket_new_file"] }
  function_name                  = each.value["function_name"]
  handler                        = each.value["handler"]
  description                    = each.value["description"]
  role                           = aws_iam_role.this[each.key].arn
  memory_size                    = each.value["memory_size"]
  reserved_concurrent_executions = each.value["reserved_concurrent_executions"]
  architectures                  = each.value["architectures"]
  runtime                        = each.value["runtime"]
  layers                         = each.value["layers"]

  package_type = each.value["package_type"]
  image_uri    = null

  filename = each.value["filename"] != null ? each.value["filename"] : format("%.zip", each.value["function_name"])
  timeout  = each.value["timeout"]

  s3_bucket         = null
  s3_key            = null
  s3_object_version = null

  /*
   * NOTE:
    * This option update the function if the .zip file changes.
    * The managed zip file is only allowed by this module when the 'var.lambda_archive_config' is passed.
  */
  source_code_hash = !each.value["enable_update_function_on_archive_change"] ? null : each.value["filename"] != null ? null : lookup(local.archive_cfg, each.key, null) != null ? data.archive_file.from_archive_source_file[each.key].output_base64sha256 : null

  /*
  * -----------------------------------
  * Tracing configuration
  * -----------------------------------
  */
  dynamic "tracing_config" {
    for_each = lookup(local.observability_cfg, each.key, null) == null ? [] : !lookup(local.observability_cfg[each.key], "tracing_enabled", false) ? [] : [local.observability_cfg[each.key]]
    content {
      mode = lookup(tracing_config.value, "tracing_mode")
    }
  }

  /*
  * -----------------------------------
  * Host configuration
  * -----------------------------------
  */
  dynamic "environment" {
    for_each = lookup(local.host_cfg, each.key, null) == null ? [] : lookup(local.host_cfg[each.key], "environment_variables", null) == null ? [] : [local.host_cfg[each.key]]
    content {
      variables = lookup(environment.value, "environment_variables", {})
    }
  }

  dynamic "ephemeral_storage" {
    for_each = lookup(local.host_cfg, each.key, null) == null ? [] : lookup(local.host_cfg[each.key], "ephemeral_storage", null) == null ? [] : [local.host_cfg[each.key]]
    content {
      size = lookup(ephemeral_storage.value, "ephemeral_storage")
    }
  }

  dynamic "file_system_config" {
    for_each = lookup(local.host_cfg, each.key, null) == null ? [] : lookup(local.host_cfg[each.key], "file_system_config", null) == null ? [] : lookup(local.host_cfg[each.key], "file_system_config")
    content {
      arn              = lookup(file_system_config.value, "arn", null)
      local_mount_path = lookup(file_system_config.value, "local_mount_path", null)
    }
  }

  /*
  * -----------------------------------
  * network configuration
  * -----------------------------------
  */
  dynamic "vpc_config" {
    for_each = lookup(local.network_cfg, each.key, null) == null ? [] : lookup(local.network_cfg[each.key], "vpc_config", null) == null ? [] : [local.network_cfg[each.key]]
    content {
      security_group_ids = lookup(vpc_config.value, "security_group_ids", [])
      subnet_ids         = lookup(vpc_config.value, "subnet_ids", [])
    }
  }


  lifecycle {
    ignore_changes = [last_modified, version]

    precondition {
      condition     = each.value["filename"] != null && can(regex(".*\\.zip", each.value["filename"]))
      error_message = "The filename should have the extension .zip, either .Zip, .ZIP or equivalent."
    }

    precondition {
      condition     = each.value["package_type"] != null && can(regex("Zip", each.value["package_type"])) && !can(regex("Image", each.value["package_type"]))
      error_message = "The package type should be set, should have the value of Zip, and not Image for this type of (deployment) AWS Lambda."
    }

    precondition {
      condition     = each.value["filename"] != null && fileexists(each.value["filename"])
      error_message = "The file that's passed to the filename should be a valid file that should exist."
    }

    precondition {
      condition     = each.value["enabled_from_file"] && !each.value["enabled_from_archive"] && !each.value["enabled_from_docker"] && !each.value["enabled_from_s3_existing_file"] && !each.value["enabled_from_s3_existing_new_file"] && !each.value["enabled_from_s3_managed_bucket_existing_file"] && !each.value["enabled_from_s3_managed_bucket_new_file"]
      error_message = "The Lambda function configuration is inconsistent, the 'enabled_from_file' is set to true, but the other options are not set to false."
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]
}

# FIXME: Can't sync the publish capability with an expected version (that shouldn't be 'LATEST').
#resource "aws_lambda_provisioned_concurrency_config" "this" {
#  for_each = { for k, v in local.lambda_cfg: k => v if v["is_provisioned_concurrency_enabled"]}
#  function_name = aws_lambda_function.this[each.key].function_name
#  qualifier = aws_lambda_function.this[each.key].version
#
#  provisioned_concurrent_executions = each.value["provision_concurrency"]
#
#  depends_on = [
#    aws_lambda_function.this,
#  ]
#}
#

resource "aws_lambda_alias" "this" {
  for_each         = local.alias_cfg
  name             = each.value["alias_name"]
  description      = each.value["description"]
  function_name    = aws_lambda_function.default[each.key].function_name
  function_version = each.value["use_default_version_from_function_enabled"] ? aws_lambda_function.default[each.key].version : each.value["function_version"]

  depends_on = [
    aws_lambda_function.default
  ]
}
