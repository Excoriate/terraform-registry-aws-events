locals {
  aws_region_to_deploy                = var.aws_region
  is_module_enabled                   = !var.is_enabled ? false : var.ses_config != null
  is_verification_config_enabled      = !var.is_enabled ? false : var.ses_verification_config != null
  is_validation_config_enabled        = !var.is_enabled ? false : var.ses_validation_config != null
  is_notification_config_enabled      = !var.is_enabled ? false : var.ses_notification_config != null
  is_template_config_enabled          = !var.is_enabled ? false : var.ses_template_config != null
  is_event_destination_config_enabled = !var.is_enabled ? false : var.ses_event_destination_config != null

  // Normalization and mapping.
  // [1.] Core configuration
  ses_config = !local.is_module_enabled ? null : [var.ses_config]
  ses_config_normalised = !local.is_module_enabled ? {} : {
    for cfg in local.ses_config : cfg["name"] => {
      name                    = trimspace(cfg["name"])
      domain                  = cfg["domain"] == null ? lower(trimspace(cfg["name"])) : lower(trimspace(cfg["domain"]))
      create_domain_mail_from = cfg["create_domain_mail_from"] == null ? false : cfg["create_domain_mail_from"]
      behavior_on_mx_failure  = cfg["behavior_on_mx_failure"] == null ? "UseDefaultValue" : cfg["behavior_on_mx_failure"]
      emails = cfg["emails"] == null ? [] : [for email in cfg["emails"] : {
        address = trimspace(email["address"])
        enabled = email["enabled"] == null ? true : email["enabled"] // It'll fallback to true if it's not set.
        domain  = cfg["domain"] == null ? lower(trimspace(cfg["name"])) : lower(trimspace(cfg["domain"]))
        name    = trimspace(cfg["name"])
      } if email["enabled"]]
  } }

  ses_config_create = !local.is_module_enabled ? {} : local.ses_config_normalised

  // [2.] Verification configuration
  ses_verification_config = !local.is_verification_config_enabled ? null : [var.ses_verification_config]
  ses_verification_config_normalised = !local.is_verification_config_enabled ? {} : {
    for cfg in local.ses_verification_config : cfg["name"] => {
      name    = trimspace(cfg["name"])
      domain  = lookup(local.ses_config_create[trimspace(cfg["name"])], "domain") // optimistically lookup the domain name from the core configuration.
      enabled = cfg["enabled"] == null ? false : cfg["enabled"]
      ttl     = cfg["ttl"] == null ? 600 : cfg["ttl"]
  } if cfg["enabled"] } // This functionality can be enabled/disabled per domain.

  ses_verification_config_create = !local.is_verification_config_enabled ? {} : local.ses_verification_config_normalised

  // [3.] Validation configuration
  ses_validation_config = !local.is_validation_config_enabled ? null : [var.ses_validation_config]
  ses_validation_config_normalised = !local.is_validation_config_enabled ? {} : {
    for cfg in local.ses_validation_config : cfg["name"] => {
      name                   = trimspace(cfg["name"])
      enable_spf_validation  = cfg["enable_spf_validation"] == null ? false : cfg["enable_spf_validation"]
      enable_dkim_validation = cfg["enable_dkim_validation"] == null ? false : cfg["enable_dkim_validation"]
  } }

  ses_validation_config_create = !local.is_validation_config_enabled ? {} : local.ses_validation_config_normalised

  // [4.] Emails identities configuration
  ses_emails_identities_config = !local.is_module_enabled ? {} : {
    for cfg in flatten([for c in local.ses_config_create : c["emails"]]) : cfg["address"] => {
      domain       = cfg["domain"]
      address      = cfg["address"]
      full_address = can(regex(format("@%s", cfg["domain"]), cfg["address"])) ? cfg["address"] : format("%s@%s", cfg["address"], cfg["domain"])
    }
  }

  // [5.] Notification configuration
  ses_notification_config = !local.is_notification_config_enabled ? null : [var.ses_notification_config]
  ses_notification_config_normalised = !local.is_notification_config_enabled ? {} : {
    for cfg in local.ses_notification_config : cfg["name"] => {
      name                     = trimspace(cfg["name"])
      topic_arn                = cfg["topic_arn"] == null ? null : cfg["topic_arn"]
      include_original_headers = cfg["include_original_headers"] == null ? false : cfg["include_original_headers"]
      notification_type        = cfg["notification_type"] == null ? "Bounce" : cfg["notification_type"]

      is_sns_topic_ooo_to_create = cfg["topic_arn"] == null // If the topic_arn is not set, then we'll create a new SNS topic.
  } }

  ses_notification_config_create = !local.is_notification_config_enabled ? {} : local.ses_notification_config_normalised

  // [6.] Template configuration
  ses_template_config = !local.is_template_config_enabled ? null : var.ses_template_config
  ses_template_config_normalised = !local.is_template_config_enabled ? [] : [
    for cfg in local.ses_template_config : {
      name    = trimspace(cfg["name"])
      subject = cfg["subject"]
      html    = cfg["html"]
      text    = cfg["text"]
    }
  ]

  ses_template_config_create = !local.is_template_config_enabled ? {} : { for cfg in local.ses_template_config_normalised : cfg["name"] => cfg }

  // [7.] Event destination configuration
  ses_event_destination_config = !local.is_event_destination_config_enabled ? null : var.ses_event_destination_config
  ses_event_destination_config_all_normalised = !local.is_event_destination_config_enabled ? [] : [
    for cfg in local.ses_event_destination_config : {
      name                   = trimspace(cfg["name"])
      enabled                = cfg["enabled"] == null ? true : cfg["enabled"] // It's enabled by default.
      matching_types         = cfg["matching_types"] == null ? ["reject", "bounce", "renderingFailure"] : [for cty in cfg["matching_types"] : trimspace(cty)]
      cloudwatch_destination = cfg["cloudwatch_destination"]
      kinesis_destination    = cfg["kinesis_destination"]
      sns_destination        = cfg["sns_destination"]
    }
  ]

  ses_event_destination_config_all_create = !local.is_event_destination_config_enabled ? {} : { for cfg in local.ses_event_destination_config_all_normalised : cfg["name"] => cfg }

  // 7.1 CloudWatch destination specific configuration.
  ses_event_destination_config_cloudwatch_normalised = !local.is_event_destination_config_enabled ? [] : [
    for cfg in local.ses_event_destination_config : {
      name                   = trimspace(cfg["name"])
      enabled                = cfg["enabled"] == null ? true : cfg["enabled"] // It's enabled by default.
      matching_types         = cfg["matching_types"] == null ? ["reject", "bounce", "renderingFailure"] : [for cty in cfg["matching_types"] : trimspace(cty)]
      cloudwatch_destination = cfg["cloudwatch_destination"]
    } if cfg["cloudwatch_destination"] != null && cfg["kinesis_destination"] == null && cfg["sns_destination"] == null
  ]

  ses_event_destination_config_cloudwatch_create = !local.is_event_destination_config_enabled ? {} : { for cfg in local.ses_event_destination_config_cloudwatch_normalised : cfg["name"] => cfg }

  // 7.2 Kinesis destination specific configuration.
  ses_event_destination_config_kinesis_normalised = !local.is_event_destination_config_enabled ? [] : [
    for cfg in local.ses_event_destination_config : {
      name                = trimspace(cfg["name"])
      enabled             = cfg["enabled"] == null ? true : cfg["enabled"] // It's enabled by default.
      matching_types      = cfg["matching_types"] == null ? ["reject", "bounce", "renderingFailure"] : [for cty in cfg["matching_types"] : trimspace(cty)]
      kinesis_destination = cfg["kinesis_destination"]
    } if cfg["kinesis_destination"] != null && cfg["cloudwatch_destination"] == null && cfg["sns_destination"] == null
  ]

  ses_event_destination_config_kinesis_create = !local.is_event_destination_config_enabled ? {} : { for cfg in local.ses_event_destination_config_kinesis_normalised : cfg["name"] => cfg }

  // 7.3 SNS destination specific configuration.
  ses_event_destination_config_sns_normalised = !local.is_event_destination_config_enabled ? [] : [
    for cfg in local.ses_event_destination_config : {
      name            = trimspace(cfg["name"])
      enabled         = cfg["enabled"] == null ? true : cfg["enabled"] // It's enabled by default.
      matching_types  = cfg["matching_types"] == null ? ["reject", "bounce", "renderingFailure"] : [for cty in cfg["matching_types"] : trimspace(cty)]
      sns_destination = cfg["sns_destination"]
    } if cfg["sns_destination"] != null && cfg["cloudwatch_destination"] == null && cfg["kinesis_destination"] == null
  ]

  ses_event_destination_config_sns_create = !local.is_event_destination_config_enabled ? {} : { for cfg in local.ses_event_destination_config_sns_normalised : cfg["name"] => cfg }
}
