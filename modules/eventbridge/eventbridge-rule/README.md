<!-- BEGIN_TF_DOCS -->
# ☁️ ECS Task definition module.
## Description

This module creates an ECS task definition with the specified name.
* 🚀 **ECS task definition**: ECS task definition with the specified name.
* 🚀 **ECS task definition revision**: ECS task definition revision with the specified name.

This module pretends to be used as a safer way to create ECS task definitions, by using the `terraform` way to create them, and parsing the resulting object as a valid .json
that can be used in an ECS service.
The ecs task definitions that can be created, can also manage two particular attributes that are usually configured outside of
terraform, these are:
* `containerDefinitions` : This attributes list particular settings of the container that will be created, such as the image, the port mappings, the environment variables, etc.
For more information, please refer to the [AWS documentation](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html).
if the option `manage_task_outside_of_terraform` is set in the input variable `var.task_config`, then the container definitions will be managed outside of terraform,
and the module will only create the task definition, but ignore any further changes to the container definitions.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "ecs_task_simple" {
  for_each   = var.scenario_simple ? { enabled = true } : {}
  source     = "../../../modules/ecs-task"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  task_config = [
    {
      name = "task1"
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = true
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
  }]
  task_permissions_config = var.task_permissions_config
}

module "ecs_task_simple_tf_unmanaged" {
  for_each   = var.scenario_tf_unmanaged ? { enabled = true } : {}
  source     = "../../../modules/ecs-task"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  task_config = [
    {
      name = "task1"
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = true
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
    }]
  task_permissions_config = var.task_permissions_config
}


module "ecs_task_simple_with_passed_policies" {
  for_each   = var.scenario_simple_passed_roles ? { enabled = true } : {}
  source     = "../../../modules/ecs-task"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  task_config = [
    {
      name = "task1"
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = true
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
  }]
  task_permissions_config = [
    {
      name               = "task1"
      task_role_arn      = aws_iam_role.task_role.arn
      execution_role_arn = aws_iam_role.execution_role.arn
    }
  ]
}



module "ecs_task_multiple" {
  for_each   = var.scenario_multiple ? { enabled = true } : {}
  source     = "../../../modules/ecs-task"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  task_config = [
    {
      name = "task1"
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = true
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
    },
    // Task 2
    {
      name = "task2"
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = false
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
    },
    // Task 3 with extra IAM policies.
    {
      name = "task3"
      enable_extra_iam_policies_arn = [
      aws_iam_policy.task_role_extra_iam_policy.arn]
      container_definition_from_json = jsonencode([
        {
          name               = "app"
          image              = "cloudposse/geodesic"
          essential          = true
          interactive        = true
          pseudo_terminal    = false
          cpu                = 256
          memory             = 256
          memory_reservation = 128
          log_configuration = {
            log_driver = "json-file"
            options = {
              "max-file" = "3"
              "max-size" = "10m"
            }
          }
          port_mappings = [
            {
              container_port = 8080
              host_port      = 80
              protocol       = "tcp"
            },
            {
              container_port = 8081
              host_port      = 443
              protocol       = "udp"
            },
          ]
          extra_hosts = [
            {
              hostname   = "app.local"
              ip_address = "127.0.0.1"
            },
          ]
          mount_points              = []
          volumes_from              = []
          privileged                = false
          read_only_root_filesystem = false
        }
      ])
    },
  ]
  task_permissions_config = [
    {
      name               = "task3"
      task_role_arn      = aws_iam_role.task_role.arn
      execution_role_arn = aws_iam_role.execution_role.arn
    }
  ]
}

resource "aws_iam_role" "execution_role" {
  name               = "task_role"
  assume_role_policy = data.aws_iam_policy_document.execution_assume_policy.json
}


data "aws_iam_policy_document" "execution_assume_policy" {

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "fargate_policy" {

  statement {
    sid    = "oooexeccommon"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "kms:Decrypt",
    ]
    resources = [
      "*"
    ]
  }
}


resource "aws_iam_policy" "execution_fargate_policy" {
  name   = "execution_fargate_policy"
  policy = data.aws_iam_policy_document.fargate_policy.json
}

resource "aws_iam_role_policy_attachment" "execution_fargate_policy_attachment" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.execution_fargate_policy.arn
}

resource "aws_iam_role" "task_role" {
  name               = "task_role_ecs_task_module"
  assume_role_policy = data.aws_iam_policy_document.task_assume_policy.json
}

data "aws_iam_policy_document" "task_assume_policy" {

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "task_role_extra_iam_policy" {
  name        = "test_extra_iam_policy"
  description = "test_extra_iam_policy"
  policy      = data.aws_iam_policy_document.test_extra_iam_policy.json
}

data "aws_iam_policy_document" "test_extra_iam_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::test-bucket",
      "arn:aws:s3:::test-bucket/*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "test_extra_iam_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_role_extra_iam_policy.arn
}
```

For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "ecs_task_definition_arn" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.arn] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.arn] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.arn] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.arn] : []
  description = "The ARN of the task definition."
}

output "ecs_task_definition_family" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.family] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.family] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.family] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.family] : []
  description = "The family of the task definition."
}

output "ecs_task_definition_revision" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.revision] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.revision] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.revision] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.revision] : []
  description = "The revision of the task definition."
}

output "ecs_task_definition_task_role_arn" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.task_role_arn] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.task_role_arn] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.task_role_arn] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.task_role_arn] : []
  description = "The ARN of the IAM role that grants containers in the task permission to call AWS APIs on your behalf."
}

output "ecs_task_definition_execution_role_arn" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.execution_role_arn] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.execution_role_arn] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.execution_role_arn] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.execution_role_arn] : []
  description = "The ARN of the IAM role that grants the Amazon ECS container agent permission to make AWS API calls on your behalf."
}

output "ecs_task_definition_network_mode" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.network_mode] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.network_mode] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.network_mode] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.network_mode] : []
  description = "The network mode of the task definition."
}

output "ecs_task_definition_container_definitions" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.container_definitions] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.container_definitions] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.container_definitions] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.container_definitions] : []
  description = "The container definitions of the task definition."
}

output "ecs_task_definition_cpu" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.cpu] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.cpu] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.cpu] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.cpu] : []
  description = "The number of CPU units used by the task."
}

output "ecs_task_definition_memory" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.memory] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.memory] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.memory] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.memory] : []
  description = "The amount (in MiB) of memory used by the task."
}

output "ecs_task_definition_proxy_configuration" {
  value       = length([for t in aws_ecs_task_definition.default : t]) > 0 ? [for t in aws_ecs_task_definition.default : t.proxy_configuration] : length([for t in aws_ecs_task_definition.default_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.default_built_in_permissions : t.proxy_configuration] : length([for t in aws_ecs_task_definition.tg_unmanaged_default : t]) > 0 ? [for t in aws_ecs_task_definition.tg_unmanaged_default : t.proxy_configuration] : length([for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t]) > 0 ? [for t in aws_ecs_task_definition.tf_unmanaged_built_in_permissions : t.proxy_configuration] : []
  description = "The proxy configuration of the task definition."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.default_built_in_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.tf_unmanaged_built_in_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.tg_unmanaged_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.execution_role_fargate_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.task_role_policy_fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role_built_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.execution_role_fargate_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_role_policy_fargate_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.execution_role_fargate_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role_policy_built_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role_policy_fargate_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_task_config"></a> [task\_config](#input\_task\_config) | A list of objects that contains the configuration for each task definition.<br>The currently supported attributes are:<br>- name: The name of the task definition.<br>- family: The family of the task definition. If not provided, it'll use the name.<br>- container\_definition\_from\_json: The JSON string that contains the container definition.<br>- container\_definition\_from\_file: The path to the file that contains the container definition.<br>- type: The type of the task definition. Valid values are: EC2, FARGATE. Default: FARGATE.<br>- network\_mode: The network mode of the task definition. Valid values are: awsvpc, bridge, host, none. Default: awsvpc.<br>- cpu: The number of CPU units to reserve for the container. Default: 256.<br>- memory: The amount of memory (in MiB) to allow the container to use. Default: 512.<br>- task\_role\_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.<br>- execution\_role\_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the task role.<br>- proxy\_configuration: The proxy configuration details for the App Mesh proxy. | <pre>list(object({<br>    // General settings<br>    name                           = string<br>    family                         = optional(string, null)<br>    container_definition_from_json = optional(string, null)<br>    container_definition_from_file = optional(string, null)<br>    type                           = optional(string, "FARGATE")<br>    network_mode                   = optional(string, "awsvpc")<br>    // Capacity<br>    cpu    = optional(number, 256)<br>    memory = optional(number, 512)<br>    // proxy_configuration<br>    proxy_configuration = optional(object({<br>      type           = string<br>      container_name = string<br>      properties = optional(list(object({<br>        name  = string<br>        value = string<br>      })), [])<br>    }), null)<br>    // Ephemeral storage<br>    ephemeral_storage = optional(number, null)<br>    task_placement_constraints = optional(list(object({<br>      type       = string<br>      expression = string<br>    })), null)<br>    service_placement_constraints = optional(list(object({<br>      type       = string<br>      expression = string<br>    })), null)<br>    runtime_platforms                = optional(list(map(string)), null)<br>    manage_task_outside_of_terraform = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_task_permissions_config"></a> [task\_permissions\_config](#input\_task\_permissions\_config) | A list of objects that contains the configuration for each task permissions.<br>The currently supported attributes are:<br>- name: The name of the task definition.<br>- task\_role\_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.<br>- execution\_role\_arn: The ARN of the IAM role that allows your Amazon ECS container task to make calls to other AWS services.<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the task role. | <pre>list(object({<br>    name                         = string<br>    task_role_arn                = optional(string, null)<br>    execution_role_arn           = optional(string, null)<br>    permissions_boundary         = optional(string, null)<br>    disable_built_in_permissions = optional(bool, false)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the task definition. |
| <a name="output_ecs_task_definition_container_definitions"></a> [ecs\_task\_definition\_container\_definitions](#output\_ecs\_task\_definition\_container\_definitions) | The container definitions of the task definition. |
| <a name="output_ecs_task_definition_cpu"></a> [ecs\_task\_definition\_cpu](#output\_ecs\_task\_definition\_cpu) | The number of CPU units used by the task. |
| <a name="output_ecs_task_definition_execution_role_arn"></a> [ecs\_task\_definition\_execution\_role\_arn](#output\_ecs\_task\_definition\_execution\_role\_arn) | The ARN of the IAM role that grants the Amazon ECS container agent permission to make AWS API calls on your behalf. |
| <a name="output_ecs_task_definition_family"></a> [ecs\_task\_definition\_family](#output\_ecs\_task\_definition\_family) | The family of the task definition. |
| <a name="output_ecs_task_definition_memory"></a> [ecs\_task\_definition\_memory](#output\_ecs\_task\_definition\_memory) | The amount (in MiB) of memory used by the task. |
| <a name="output_ecs_task_definition_network_mode"></a> [ecs\_task\_definition\_network\_mode](#output\_ecs\_task\_definition\_network\_mode) | The network mode of the task definition. |
| <a name="output_ecs_task_definition_proxy_configuration"></a> [ecs\_task\_definition\_proxy\_configuration](#output\_ecs\_task\_definition\_proxy\_configuration) | The proxy configuration of the task definition. |
| <a name="output_ecs_task_definition_revision"></a> [ecs\_task\_definition\_revision](#output\_ecs\_task\_definition\_revision) | The revision of the task definition. |
| <a name="output_ecs_task_definition_task_role_arn"></a> [ecs\_task\_definition\_task\_role\_arn](#output\_ecs\_task\_definition\_task\_role\_arn) | The ARN of the IAM role that grants containers in the task permission to call AWS APIs on your behalf. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
