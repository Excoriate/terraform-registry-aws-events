resource "aws_lambda_function" "from_s3_existing" {
  for_each                       = { for k, v in local.lambda_cfg : k => v if !v["enabled_from_file"] && !v["enabled_from_archive"] && !v["enabled_from_docker"] && v["enabled_from_s3_existing_file"] && !v["enabled_from_s3_existing_new_file"] && !v["enabled_full_managed"] }
  function_name                  = each.value["function_name"]
  handler                        = each.value["handler"]
  description                    = each.value["description"]
  role                           = aws_iam_role.this[each.key].arn
  memory_size                    = each.value["memory_size"]
  reserved_concurrent_executions = each.value["reserved_concurrent_executions"]
  architectures                  = each.value["architectures"]
  runtime                        = each.value["runtime"]
  layers                         = each.value["layers"]

  package_type = "Zip"
  image_uri    = null

  filename = null
  timeout  = each.value["timeout"]

  s3_bucket         = lookup(local.s3_from_existing_cfg[each.key], "s3_bucket")
  s3_key            = lookup(local.s3_from_existing_cfg[each.key], "s3_key")
  s3_object_version = lookup(local.s3_from_existing_cfg[each.key], "ignore_version_changes_enabled", false) ? null : lookup(local.s3_from_existing_cfg[each.key], "s3_object_version")

  source_code_hash = null
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
      condition     = !each.value["enabled_from_file"] && !each.value["enabled_from_archive"] && !each.value["enabled_from_docker"] && each.value["enabled_from_s3_existing_file"] && !each.value["enabled_from_s3_existing_new_file"] && !each.value["enabled_full_managed"]
      error_message = "The deployment method should be set to 'enabled_from_s3_existing_file'. If so, all the other deployment methods should be set to false."
    }

    precondition {
      condition     = lookup(local.s3_from_existing_cfg[each.key], "s3_bucket", null) != null && lookup(local.s3_from_existing_cfg[each.key], "s3_key", null) != null
      error_message = "The s3_bucket and s3_key properties are required when the deployment method is set to 'enabled_from_s3_existing_file'."
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]
  tags = var.tags

}
