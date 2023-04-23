resource "aws_lambda_function" "this" {
  for_each                       = local.lambda_cfg
  function_name                  = each.value["function_name"]
  handler                        = each.value["handler"]
  description                    = each.value["description"]
  role                           = aws_iam_role.this[each.key].arn
  memory_size                    = each.value["memory_size"]
  reserved_concurrent_executions = each.value["reserved_concurrent_executions"]
  architectures                  = each.value["architectures"]
  runtime                        = each.value["runtime"]
  layers                         = each.value["layers"]
  /*
   * NOTE:
    * If the 'package_type' is passed, it'll take precedence
    * If the 'package_type' is not passed, it'll try to resolve the type by looking at the 'filename'. If the 'filename' is passed and includes the word '.zip'
    * it'll be considered as a Zip package. If the 'filename' is passed and doesn't include the word '.zip', it'll be considered as an Image package.
    * If the 'filename' is not passed, it'll try to resolve the type by looking at the 'var.lambda_image_config'. If the 'var.lambda_image_config' is passed,
  */
  package_type = each.value["package_type"] != null ? each.value["package_type"] : lookup(local.lambda_image_cfg, each.key, null) == null ? "Zip" : "Image"
  image_uri    = each.value["filename"] != null ? null : lookup(local.lambda_image_cfg, each.key, null) == null ? null : lookup(local.lambda_image_cfg[each.key], "image_uri")
  /*
   * NOTE:
    * If the 'filename' is passed, it'll take precedence
    * If the filename is passed, but it's passed as "" (empty string), it'll use the function name for looking at the filename
    * If the 'var.lambda_archive_config' is passed and the filename is NULL, it'll take precedence
    * If neither the 'filename' is passed nor the 'var.lambda_archive_config' is passed, it'll use the 'var.lambda_image_config' and take the 'image_uri' from there
  */
  filename = each.value["filename"] != null ? each.value["filename"] : (lookup(local.archive_cfg, each.key, null) == null || length(keys(lookup(local.archive_cfg, each.key))) == 0) ? format("%.zip", each.value["function_name"]) : lookup(local.archive_cfg[each.key], "source_file", null) != null ? data.archive_file.source_file[each.key].output_path : data.archive_file.source_file[each.key].output_path
  timeout  = each.value["timeout"]
  /*
   * NOTE:
    * The S3 configuration is only used if the 'filename' is not passed:
    * If it's passed, it'll take precedence
  */
  s3_bucket         = each.value["filename"] != null ? null : lookup(local.s3_deploy_cfg, each.key, null) == null ? null : lookup(local.s3_deploy_cfg[each.key], "s3_bucket")
  s3_key            = each.value["filename"] != null ? null : lookup(local.s3_deploy_cfg, each.key, null) == null ? null : lookup(local.s3_deploy_cfg[each.key], "s3_key")
  s3_object_version = each.value["filename"] != null ? null : lookup(local.s3_deploy_cfg, each.key, null) == null ? null : lookup(local.s3_deploy_cfg[each.key], "s3_object_version")

  /*
   * NOTE:
    * This option update the function if the .zip file changes.
    * The managed zip file is only allowed by this module when the 'var.lambda_archive_config' is passed.
  */
  source_code_hash = !each.value["enable_update_function_on_archive_change"] ? null : each.value["filename"] != null ? null : lookup(local.archive_cfg, each.key, null) != null ? data.archive_file.source_file[each.key].output_base64sha256 : null

  /*
  * -----------------------------------
  * Image (container) configuration
  * -----------------------------------
  */
  dynamic "image_config" {
    for_each = each.value["filename"] != null ? [] : lookup(local.lambda_image_cfg, each.key, null) == null ? [] : [local.lambda_image_cfg[each.key]]
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
      condition     = each.value["filename"] == null || (each.value["filename"] == "" && (each.value["function_name"] != null || each.value["function_name"] != ""))
      error_message = "The 'filename' is empty, however, the 'function_name' is also either null or empty. The function name is required when the 'filename' is empty to form the filename name by default <function_name>.zip."
    }

    precondition {
      condition     = each.value["filename"] == null || each.value["filename"] == "" || lookup(local.archive_cfg, each.key, null) != null || lookup(local.s3_deploy_cfg, each.key, null) != null || lookup(local.lambda_image_cfg, each.key, null) != null
      error_message = "The 'filename' is null or empty. It's allowed only if the 'var.lambda_archive_config' is passed, the 'var.s3_deploy_config' is passed or the 'var.lambda_image_config' is passed."
    }


    precondition {
      condition     = each.value["filename"] == null || (each.value["filename"] != null && each.value["package_type"] == "Zip" && lookup(local.lambda_image_cfg, each.key, null) == null)
      error_message = "The 'filename' is passed and the 'package_type' is 'Zip', but the 'var.lambda_image_config' is also passed. Please, remove the 'var.lambda_image_config' or remove the 'filename' to use the default value."
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
  function_name    = aws_lambda_function.this[each.key].function_name
  function_version = each.value["use_default_version_from_function_enabled"] ? aws_lambda_function.this[each.key].version : each.value["function_version"]

  depends_on = [
    aws_lambda_function.this
  ]
}
