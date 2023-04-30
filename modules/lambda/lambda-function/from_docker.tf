resource "aws_lambda_function" "from_docker" {
  for_each                       = { for k, v in local.lambda_cfg : k => v if !v["enabled_from_file"] && !v["enabled_from_archive"] && v["enabled_from_docker"] && !v["enabled_from_s3_existing_file"] && !v["enabled_from_s3_existing_new_file"] && !v["enabled_from_s3_managed_bucket_existing_file"] && !v["enabled_from_s3_managed_bucket_new_file"] }
  function_name                  = each.value["function_name"]
  handler                        = null
  description                    = each.value["description"]
  role                           = aws_iam_role.this[each.key].arn
  memory_size                    = each.value["memory_size"]
  reserved_concurrent_executions = each.value["reserved_concurrent_executions"]
  architectures                  = each.value["architectures"]
  runtime                        = null
  layers                         = null

  package_type = "Image"
  image_uri    = lookup(local.lambda_docker_cfg[each.key], "image_uri")

  filename          = null
  timeout           = each.value["timeout"]
  s3_bucket         = null
  s3_key            = null
  s3_object_version = null
  source_code_hash  = null

  /*
    * -----------------------------------
    * Image (container) configuration
    * -----------------------------------
    */
  dynamic "image_config" {
    for_each = lookup(local.lambda_docker_cfg, each.key, null) == null ? [] : [local.lambda_docker_cfg[each.key]]
    content {
      command           = lookup(image_config.value, "command", null)
      entry_point       = lookup(image_config.value, "entry_point", null)
      working_directory = lookup(image_config.value, "working_directory", null)
    }
  }


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
      condition     = !each.value["enabled_from_file"] && !each.value["enabled_from_archive"] && each.value["enabled_from_docker"] && !each.value["enabled_from_s3_existing_file"] && !each.value["enabled_from_s3_existing_new_file"] && !each.value["enabled_from_s3_managed_bucket_existing_file"] && !each.value["enabled_from_s3_managed_bucket_new_file"]
      error_message = "The deployment method should be set to 'enabled_from_docker'. If so, all the other deployment methods should be set to false."
    }

    precondition {
      condition     = each.value["handler"] == null
      error_message = "The handler shouldn't be provided, and should be passed as null. It's incompatible with the Image package type."
    }

    precondition {
      condition     = can(regex("^([0-9]{12}).dkr.ecr.([a-z0-9-]+).amazonaws.com/([a-z0-9._-]+)(:[a-zA-Z0-9._-]+)?$", lookup(local.lambda_docker_cfg[each.key], "image_uri")))
      error_message = "The image_uri should be a valid ECR URI. Please check the format."
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]
}
