<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/auto-scaling/app-auto-scaling | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_config"></a> [auto\_scaling\_config](#input\_auto\_scaling\_config) | A configuration object, that defines an auto-scaling configuration for an application in AWS. This object doesn't<br>define the auto-scaling specifics configuration. For such configurations, please refer to the input variable<br>'var.auto\_scaling\_ecs\_config' or the one that corresponds to the specific AWS application (DynamoDB, Aurora, ECS, etc.)<br>The current attributes that are supported are:<br>- name: Unique identifier for this auto-scaling configuration.<br>- type: The type of the auto-scaling configuration. E.g.: ecs, dynamodb, aurora.<br>- resource\_id: Unique identifier for this auto-scaling configuration.<br>- dimension: The dimension of the auto-scaling configuration.<br>- min\_capacity: The minimum capacity of the auto-scaling configuration.<br>- max\_capacity: The maximum capacity of the auto-scaling configuration.<br>- role\_arn: The ARN of the IAM role that allows Application Auto Scaling to modify your scalable target on your behalf. | <pre>list(object({<br>    name         = string<br>    type         = string<br>    resource_id  = string<br>    dimension    = string<br>    min_capacity = optional(number, 1)<br>    max_capacity = optional(number, 1)<br>    role_arn     = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_auto_scaling_ecs_config"></a> [auto\_scaling\_ecs\_config](#input\_auto\_scaling\_ecs\_config) | A configuration object, that defines an auto-scaling configuration for an application in AWS. This<br>  configuration is used to configure the auto-scaling for an application in AWS.<br>Current attributes supported:<br>- name: Unique identifier for this auto-scaling configuration.<br>- adjustment\_type: The adjustment type, which specifies how ScalingAdjustment is interpreted. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.<br>- metric\_aggregation\_type: The aggregation type for the CloudWatch metrics. Valid values are Minimum, Maximum, and Average.<br>- scale\_up\_cool\_down: The amount of time, in seconds, after a scale in activity completes before another scale in activity can start.<br>- scale\_down\_cool\_down: The amount of time, in seconds, after a scale out activity completes before another scale out activity can start.<br>- scale\_up\_adjustment: The amount by which to scale, based on the specified adjustment type. A positive value adds to the current capacity while a negative number removes from the current capacity.<br>- scale\_down\_adjustment: The amount by which to scale, based on the specified adjustment type. A positive value adds to the current capacity while a negative number removes from the current capacity.<br>- target\_metric\_type: The metric type. The only valid value is ECSServiceAverageCPUUtilization.<br>- target\_metric\_value: The target value for the metric. | <pre>list(object({<br>    name                    = string<br>    adjustment_type         = optional(string, "ChangeInCapacity")<br>    metric_aggregation_type = optional(string, "Average")<br>    scale_up_cool_down      = optional(number, 60)<br>    scale_down_cool_down    = optional(number, 60)<br>    scale_up_adjustment     = optional(number, 1)<br>    scale_down_adjustment   = optional(number, -1)<br>    target_metric_type      = optional(string, "ECSServiceAverageCPUUtilization")<br>    target_metric_value     = optional(number, 50)<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_autoscaling_ecs_id"></a> [app\_autoscaling\_ecs\_id](#output\_app\_autoscaling\_ecs\_id) | The ID of the application autoscaling target for ECS. |
| <a name="output_app_autoscaling_ecs_max_capacity"></a> [app\_autoscaling\_ecs\_max\_capacity](#output\_app\_autoscaling\_ecs\_max\_capacity) | The maximum capacity of the application autoscaling target for ECS. |
| <a name="output_app_autoscaling_ecs_min_capacity"></a> [app\_autoscaling\_ecs\_min\_capacity](#output\_app\_autoscaling\_ecs\_min\_capacity) | The minimum capacity of the application autoscaling target for ECS. |
| <a name="output_app_autoscaling_ecs_resource_id"></a> [app\_autoscaling\_ecs\_resource\_id](#output\_app\_autoscaling\_ecs\_resource\_id) | The resource ID of the application autoscaling target for ECS. |
| <a name="output_app_autoscaling_ecs_role_arn"></a> [app\_autoscaling\_ecs\_role\_arn](#output\_app\_autoscaling\_ecs\_role\_arn) | The ARN of the application autoscaling target for ECS. |
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
<!-- END_TF_DOCS -->
