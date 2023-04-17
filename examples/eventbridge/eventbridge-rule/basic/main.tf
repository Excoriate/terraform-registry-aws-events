module "ecs_task_simple" {
  for_each   = var.scenario_simple ? { enabled = true } : {}
  source     = "../../../../modules/eventbridge/eventbridge-rule"
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
  source     = "../../../../modules/eventbridge/eventbridge-rule"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  task_config = [
    {
      name = "task1"
      container_definition_from_json = jsonencode([
        {
          name                             = "app"
          image                            = "cloudposse/geodesic"
          essential                        = true
          interactive                      = true
          pseudo_terminal                  = true
          cpu                              = 256
          memory                           = 256
          memory_reservation               = 128
          manage_task_outside_of_terraform = true
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
  source     = "../../../../modules/eventbridge/eventbridge-rule"
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
  source     = "../../../../modules/eventbridge/eventbridge-rule"
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
