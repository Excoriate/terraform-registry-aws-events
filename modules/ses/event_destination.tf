##########################################
# SES Configuration set
##########################################
resource "aws_ses_configuration_set" "this" {
  for_each = local.ses_event_destination_config_all_create
  name     = format("%s-config-set", each.key)
}

##########################################
# SES Configuration set
##########################################
// Cloudwatch event destination.
resource "aws_ses_event_destination" "event_cloudwatch" {
  for_each               = local.ses_event_destination_config_cloudwatch_create
  name                   = format("%s-cloudwatch", each.value["name"])
  configuration_set_name = aws_ses_configuration_set.this[each.key].name
  enabled                = each.value["enabled"]
  matching_types         = each.value["matching_types"]

  cloudwatch_destination {
    default_value  = lookup(each.value["cloudwatch_destination"], "default_value", null)
    dimension_name = lookup(each.value["cloudwatch_destination"], "dimension_name", null)
    value_source   = lookup(each.value["cloudwatch_destination"], "value_source", null)
  }
}

// Kinesis firehose event destination.
resource "aws_ses_event_destination" "event_kinesis_firehose" {
  for_each               = local.ses_event_destination_config_kinesis_create
  name                   = format("%s-kinesis-firehose", each.value["name"])
  configuration_set_name = aws_ses_configuration_set.this[each.key].name
  enabled                = each.value["enabled"]
  matching_types         = each.value["matching_types"]

  kinesis_destination {
    role_arn   = lookup(each.value["kinesis_destination"], "role_arn", null)
    stream_arn = lookup(each.value["kinesis_destination"], "stream_arn", null)
  }
}

// SNS event destination.
resource "aws_ses_event_destination" "event_sns" {
  for_each               = local.ses_event_destination_config_sns_create
  name                   = format("%s-sns", each.value["name"])
  configuration_set_name = aws_ses_configuration_set.this[each.key].name
  enabled                = each.value["enabled"]
  matching_types         = each.value["matching_types"]

  sns_destination {
    topic_arn = lookup(each.value["sns_destination"], "topic_arn", null)
  }
}
