locals {
  aws_region_to_deploy                   = var.aws_region
  is_module_enabled                      = !var.is_enabled ? false : var.lambda_config == null ? false : length(var.lambda_config) > 0
  is_lambda_permissions_config_enabled   = !local.is_module_enabled ? false : var.lambda_permissions_config == null ? false : length(var.lambda_permissions_config) > 0
  is_lambda_archive_config_enabled       = !local.is_module_enabled ? false : var.lambda_archive_config == null ? false : length(var.lambda_archive_config) > 0
  is_lambda_docker_config_enabled        = !local.is_module_enabled ? false : var.lambda_image_config == null ? false : length(var.lambda_image_config) > 0
  is_lambda_custom_policy_arns_enabled   = !local.is_module_enabled ? false : var.lambda_custom_policies_config == null ? false : length(var.lambda_custom_policies_config) > 0
  is_lambda_eventbridge_enabled          = !local.is_module_enabled ? false : var.lambda_enable_eventbridge == null ? false : length(var.lambda_enable_eventbridge) > 0
  is_lambda_secrets_manager_enabled      = !local.is_module_enabled ? false : var.lambda_enable_secrets_manager == null ? false : length(var.lambda_enable_secrets_manager) > 0
  is_lambda_host_config_enabled          = !local.is_module_enabled ? false : var.lambda_host_config == null ? false : length(var.lambda_host_config) > 0
  is_lambda_network_config_enabled       = !local.is_module_enabled ? false : var.lambda_network_config == null ? false : length(var.lambda_network_config) > 0
  is_lambda_observability_config_enabled = !local.is_module_enabled ? false : var.lambda_observability_config == null ? false : length(var.lambda_observability_config) > 0
  is_lambda_alias_config_enabled         = !local.is_module_enabled ? false : var.lambda_alias_config == null ? false : length(var.lambda_alias_config) > 0
  is_s3_from_bucket_config_enabled       = !local.is_module_enabled ? false : var.lambda_s3_from_bucket_config == null ? false : length(var.lambda_s3_from_bucket_config) > 0

  /*
    * -------------------------------
    * Lambda main configuration
    * -------------------------------
  */
  lambda = !local.is_module_enabled ? [] : [
    for l in var.lambda_config : {
      name          = trimspace(lower(l.name))
      function_name = l["function_name"] == null ? trimspace(l.name) : l["function_name"]
      description   = l["description"] == null ? format("Lambda function for %s", trimspace(l.name)) : l["description"]
      memory_size   = l["memory_size"] == null ? 128 : l["memory_size"]
      filename      = l["filename"] == null ? null : trimspace(l["filename"])
      architectures = l["architectures"] == null ? ["x86_64"] : l["architectures"]
      // Since the handler is mandatory, but it's incompatible with the 'Image' package type, it's handled at the normalizer.
      handler                        = l["deployment_type"] == null ? l.handler : lookup(l["deployment_type"], "from_docker", false) ? null : l.handler
      reserved_concurrent_executions = l["reserved_concurrent_executions"]
      #      provision_concurrency             = l["provision_concurrency"]
      runtime                                  = l["runtime"] == null ? null : trimspace(l["runtime"])
      layers                                   = l["layers"] == null ? [] : [for layer in l["layers"] : trimspace(layer)]
      package_type                             = l["package_type"] != null ? trimspace(l["package_type"]) : (l["filename"] != null && length(regexall("(?i)\\.zip$", l["filename"])) > 0) ? "Zip" : "Image"
      publish                                  = l["publish"] == null ? false : l["publish"]
      timeout                                  = l["timeout"] == null ? 3 : l["timeout"]
      enable_update_function_on_archive_change = l["enable_update_function_on_archive_change"] == null ? false : l["enable_update_function_on_archive_change"]
      // Options that describe the deployment types:
      enabled_from_file                            = l["deployment_type"] == null ? true : lookup(l["deployment_type"], "from_file", false) == true
      enabled_from_archive                         = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_archive", false) == true
      enabled_from_docker                          = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_docker", false) == true
      enabled_from_s3_existing_file                = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_s3_existing_file", false) == true
      enabled_from_s3_new_file                     = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_s3_new_file", false) == true
      enabled_from_s3_managed_bucket_existing_file = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_s3_managed_bucket_existing_file", false) == true
      enabled_from_s3_managed_bucket_new_file      = l["deployment_type"] == null ? false : lookup(l["deployment_type"], "from_s3_managed_bucket_new_file", false) == true
    }
  ]

  lambda_cfg = !local.is_module_enabled ? {} : {
    for l in local.lambda : l["name"] => l
  }

  /*
    * -------------------------------
    * Lambda alias configuration
    * -------------------------------
  */
  alias = !local.is_lambda_alias_config_enabled ? [] : [
    for a in var.lambda_alias_config : {
      name             = trimspace(lower(a.name))
      alias_name       = trimspace(a.alias_name)
      description      = a["description"] == null ? format("Lambda function alias for %s", trimspace(a.name)) : a["description"]
      function_version = a["function_version"] == null ? null : trimspace(a["function_version"])
      routing_config   = a["routing_config"] == null ? null : a["routing_config"]
      // If not, it'll use what's passed in the function_version.
      use_default_version_from_function_enabled = a["function_version"] == null
    }
  ]

  alias_cfg = !local.is_lambda_alias_config_enabled ? {} : {
    for a in local.alias : a["name"] => a
  }


  /*
    * -------------------------------
    * Lambda archive configuration
    * -------------------------------
  */
  archive = !local.is_lambda_archive_config_enabled ? [] : [
    for a in var.lambda_archive_config : {
      name           = trimspace(lower(a.name))
      function_name  = a["function_name"] == null ? trimspace(a.name) : a["function_name"]
      source_dir     = a["source_dir"] == null ? null : trimspace(a["source_dir"])
      source_file    = a["source_file"] == null ? null : trimspace(a["source_file"])
      package_name   = trimspace(a["package_name"])
      excluded_files = a["excluded_files"] == null ? [] : [for file in a["excluded_files"] : trimspace(file)]
    }
  ]

  archive_cfg = !local.is_lambda_archive_config_enabled ? {} : {
    for a in local.archive : a["name"] => a
  }

  /*
    * -------------------------------
    * Lambda S3 (deployment) configuration
    * -------------------------------
  */
  s3_deploy = !local.is_s3_from_bucket_config_enabled ? [] : [
    for s in var.lambda_s3_from_bucket_config : {
      name            = trimspace(lower(s.name))
      s3_bucket       = s["s3_bucket"] == null ? null : trimspace(s["s3_bucket"])
      source_zip_file = s["source_zip_file"] == null ? null : trimspace(s["source_zip_file"])
      source_file     = s["source_config"] == null ? null : trimspace(s["source_config"]["source_file"])
      source_dir      = s["source_config"] == null ? null : trimspace(s["source_config"]["source_dir"])

      // feature flags
      is_existing_zip_file             = s["source_zip_file"] != null
      is_zip_to_be_generated_from_file = s["source_config"] == null ? false : lookup(s["source_config"], "source_file", null) != null
      is_zip_to_be_generated_from_dir  = s["source_config"] == null ? false : lookup(s["source_config"], "source_dir", null) != null && lookup(s["source_config"], "source_file", null) == null
    }
  ]

  s3_deploy_cfg = !local.is_s3_from_bucket_config_enabled ? {} : {
    for s in local.s3_deploy : s["name"] => s
  }


  /*
    * -------------------------------
    * Lambda image configuration
    * -------------------------------
  */
  lambda_docker = !local.is_lambda_docker_config_enabled ? [] : [
    for i in var.lambda_image_config : {
      name          = trimspace(lower(i.name))
      function_name = i["function_name"] == null ? trimspace(i.name) : i["function_name"]
      image_uri     = i["image_uri"]
      ecr_arn       = i["ecr_arn"] == null ? null : trimspace(i["ecr_arn"])
      image_config = i["image_config"] == null ? [] : [
        for c in i["image_config"] : {
          command           = c["command"] == null ? [] : c["command"]
          entry_point       = c["entry_point"] == null ? [] : c["entry_point"]
          working_directory = c["working_directory"] == null ? null : c["working_directory"]
        }
      ]
    }
  ]

  lambda_docker_cfg = !local.is_lambda_docker_config_enabled ? {} : {
    for i in local.lambda_docker : i["name"] => i
  }

  /*
    * -------------------------------
    * Observability configuration.
    * -------------------------------
  */
  observability_normalised = !local.is_lambda_observability_config_enabled ? [] : [
    for config in var.lambda_observability_config : {
      name                   = trimspace(lower(config.name))
      log_group_name         = format("%s-logs", config.name)
      logs_retention_in_days = config["logs_retention_in_days"] == null ? 0 : config["logs_retention_in_days"]
      tracing_enabled        = config["tracing_enabled"] == null ? false : config["tracing_enabled"]
      tracing_mode           = config["tracing_mode"] == null ? "PassThrough" : config["tracing_mode"]
      is_enabled             = config["logs_enabled"] == null ? true : config["logs_enabled"]
    }
  ]

  observability_cfg = !local.is_lambda_observability_config_enabled ? {} : {
    for config in local.observability_normalised : config["name"] => config
  }

  /*
    * -------------------------------
    * Host configuration
     - Environment variables
     - Ephemeral storage
    * -------------------------------
  */
  host = !local.is_lambda_host_config_enabled ? [] : [
    for e in var.lambda_host_config : {
      name                  = trimspace(lower(e.name))
      environment_variables = e["environment_variables"] == null ? {} : e["environment_variables"]
      ephemeral_storage     = e["ephemeral_storage"] == null ? null : e["ephemeral_storage"]
      file_system_config = e["file_system_config"] == null ? [] : [
        for f in e["file_system_config"] : {
          arn              = f["arn"] == null ? null : f["arn"]
          local_mount_path = f["local_mount_path"] == null ? null : f["local_mount_path"]
        }
      ]
    }
  ]

  host_cfg = !local.is_lambda_host_config_enabled ? {} : {
    for e in local.host : e["name"] => e
  }

  network = !local.is_lambda_network_config_enabled ? [] : [
    for n in var.lambda_network_config : {
      name               = trimspace(lower(n.name))
      subnet_ids         = n["subnet_ids"] == null ? [] : n["subnet_ids"]
      security_group_ids = n["security_group_ids"] == null ? [] : n["security_group_ids"]
    }
  ]

  network_cfg = !local.is_lambda_network_config_enabled ? {} : {
    for n in local.network : n["name"] => n
  }


  /*
    * -------------------------------
    * Permissions configuration
    * 1. Main role creation.
    * -------------------------------
  */
  permissions_normalised = !local.is_lambda_permissions_config_enabled ? [] : [
    for p in var.lambda_permissions_config : {
      name                  = trimspace(lower(p.name))
      permissions_boundary  = p["permissions_boundary"] == null ? null : p["permissions_boundary"]
      force_detach_policies = true
      trusted_entities = p["trusted_principals"] == null ? [] : [
        for tp in p["trusted_principals"] : {
          type        = tp["type"] == null ? "AWS" : tp["type"]
          identifiers = tp["identifiers"] == null ? [] : tp["identifiers"]
        }
      ]
    }
  ]

  permissions_cfg = !local.is_lambda_permissions_config_enabled ? {} : {
    for p in local.permissions_normalised : p["name"] => p
  }

  /*
    * -------------------------------
    * Permissions configuration
    * 2. Attach custom policy arns, if they are passed
    * -------------------------------
  */
  custom_policies_cfg = !local.is_lambda_custom_policy_arns_enabled ? [] : flatten([
    for role_config in var.lambda_custom_policies_config : [
      for policy_arn in role_config["policy_arns"] : {
        name       = trimspace(lower(role_config["name"]))
        policy_arn = policy_arn
      }
    ]
  ])

  /*
    * -------------------------------
    * Permissions configuration
    * 3. Eventbridge permissions over this function
    * -------------------------------
  */
  eventbridge = !local.is_lambda_eventbridge_enabled ? [] : [
    for e in var.lambda_enable_eventbridge : {
      name       = trimspace(lower(e.name))
      source_arn = e.source_arn
      qualifier  = e["qualifier"] == null ? null : e["qualifier"]
    }
  ]

  eventbridge_cfg = !local.is_lambda_eventbridge_enabled ? {} : {
    for e in local.eventbridge : e["name"] => e
  }

  /*
    * -------------------------------
    * Permissions configuration
    * 3. Eventbridge permissions over this function
    * -------------------------------
  */
  secretsmanager = !local.is_lambda_secrets_manager_enabled ? [] : [
    for s in var.lambda_enable_secrets_manager : {
      name       = trimspace(lower(s.name))
      secret_arn = s.secret_arn
      qualifier  = s["qualifier"] == null ? null : s["qualifier"]
    }
  ]

  secretsmanager_cfg = !local.is_lambda_secrets_manager_enabled ? {} : {
    for s in local.secretsmanager : s["name"] => s
  }
}
