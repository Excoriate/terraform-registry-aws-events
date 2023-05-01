resource "aws_lambda_function" "from_archive" {
  for_each                       = { for k, v in local.lambda_cfg : k => v if !v["enabled_from_file"] && v["enabled_from_archive"] && !v["enabled_from_docker"] && !v["enabled_from_s3_existing_file"] && !v["enabled_from_s3_existing_new_file"] && !v["enabled_full_managed"] }
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

  filename = lookup(local.archive_cfg[each.key], "source_file", null) != null ? data.archive_file.from_archive_source_file[each.key].output_path : data.archive_file.from_archive_source_dir[each.key].output_path
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
      condition     = each.value["package_type"] != null && can(regex("Zip", each.value["package_type"])) && !can(regex("Image", each.value["package_type"]))
      error_message = "The package type should be set, should have the value of Zip, and not Image for this type of (deployment) AWS Lambda."
    }

    precondition {
      condition     = lookup(local.archive_cfg[each.key], "source_file", null) != null ? length(regexall("\\.(js|py|go|java|rs)$", lookup(local.archive_cfg[each.key], "source_file"))) > 0 : true
      error_message = "The file that's passed to the filename should have a valid extension such as: .js, .py, .go, .java, .rs."
    }

    precondition {
      condition     = !each.value["enabled_from_file"] && each.value["enabled_from_archive"] && !each.value["enabled_from_docker"] && !each.value["enabled_from_s3_existing_file"] && !each.value["enabled_from_s3_existing_new_file"] && !each.value["enabled_full_managed"]
      error_message = "The deployment method should be set to 'enabled_from_archive'. If so, all the other deployment methods should be set to false."
    }

    precondition {
      condition     = lookup(local.archive_cfg[each.key], "source_file", null) == null || lookup(local.archive_cfg[each.key], "source_dir", null) == null
      error_message = "The source_file and source_dir should be set to null if the other is set."
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]
  tags = var.tags
}
