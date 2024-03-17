<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Lambda Function
## Description

This module provides the following capabilities:
* 🚀 **Simple Lambda Function**: Create a Lambda function using a pre-existing zip file, a file compressed by the module, or a directory with source code.
* 🚀 **S3 Bucket Integration**: Use an existing S3 bucket to store the Lambda package or create a fully managed setup with best-practices for versioning and lifecycle.
* 🚀 **Built-in Permissions**: Includes built-in permissions for AWS Secrets Manager (for secret rotation), EventBridge, and other services.
* 🚀 **Custom Policies**: Supports attaching custom IAM policies to the Lambda execution role.
* 🚀 **built-in role**: Supports using a pre-existing role or creating a new one.
* 🚀 **Observability**: Supports CloudWatch Logs, X-Ray, and CloudWatch Metrics.


---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                                  = "../../../../modules/lambda/lambda-function"
  is_enabled                              = var.is_enabled
  aws_region                              = var.aws_region
  lambda_config                           = var.lambda_config
  lambda_archive_config                   = var.lambda_archive_config
  lambda_observability_config             = var.lambda_observability_config
  lambda_image_config                     = var.lambda_image_config
  lambda_permissions_config               = var.lambda_permissions_config
  lambda_custom_policies_config           = var.lambda_custom_policies_config
  lambda_enable_eventbridge               = var.lambda_enable_eventbridge
  lambda_enable_secrets_manager           = var.lambda_enable_secrets_manager
  lambda_host_config                      = var.lambda_host_config
  lambda_network_config                   = var.lambda_network_config
  lambda_alias_config                     = var.lambda_alias_config
  lambda_s3_from_existing_config          = var.lambda_s3_from_existing_config
  lambda_s3_from_existing_new_file_config = var.lambda_s3_from_existing_new_file_config
  lambda_full_managed_config              = var.lambda_full_managed_config

  depends_on = [
    data.archive_file.source_zip_file
  ]
}

data "archive_file" "source_zip_file" {
  type             = "zip"
  output_file_mode = "0666"
  output_path      = "lambda.zip" // It's referenced as such in the values passed in the default fixtures.tfvars file.
  source_file      = "handler.js"
}
```
## Recipes
### Very basic configuration.
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    filename      = "lambda.zip"
  }
]

lambda_observability_config = [
  {
    name         = "lambda-func-test"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
```
### Advanced configuration
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    publish       = true
    filename      = "lambda.zip"
    #    provision_concurrency = 2
    runtime = "nodejs16.x"
    timeout = 10
  }
]

lambda_observability_config = [
  {
    name            = "lambda-func-test"
    logs_enabled    = true
    tracing_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
      "ENV_VAR3" = "value3"
    }
  }
]

lambda_alias_config = [
  {
    name       = "lambda-func-test"
    alias_name = "test"
  }
]
```

### Archive directory
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    runtime       = "nodejs18.x"
    timeout       = 20
    deployment_type = {
      from_archive = true
    }
  }
]

lambda_observability_config = [
  {
    name            = "lambda-func-test"
    logs_enabled    = true
    tracing_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR" = "from-archive"
    }
  }
]

lambda_archive_config = [
  {
    name         = "lambda-func-test"
    source_dir   = "./mock/archive-dir"
    package_name = "deployed_from_archive_dir_terraform.zip"
  }
]
```
Also, it supports a managed archive with excluded files
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    runtime       = "nodejs18.x"
    timeout       = 20
    deployment_type = {
      from_archive = true
    }
  }
]

lambda_observability_config = [
  {
    name            = "lambda-func-test"
    logs_enabled    = true
    tracing_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR" = "from-archive"
    }
  }
]

lambda_archive_config = [
  {
    name         = "lambda-func-test"
    source_dir   = "." // Current directory
    package_name = "deployed_from_archive_dir_excluded_terraform.zip"
    excluded_files = [
      ".terraform",
      ".git",
      ".gitignore",
      ".DS_Store",
      "README.md",
      "LICENSE",
      "config",
      "output.tf",
      "variables.tf",
      "providers.tf",
      "terraform.tfstate",
      "terraform.tfstate.backup",
      "versions.tf",
    "main.tf", ]
  }
]
```

### Create an archive from a file
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-test"
    function_name = "simple-basic-function"
    handler       = "handler.handler"
    runtime       = "nodejs18.x"
    timeout       = 20
    deployment_type = {
      from_archive = true
    }
  }
]

lambda_observability_config = [
  {
    name            = "lambda-func-test"
    logs_enabled    = true
    tracing_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-test"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-test"
    environment_variables = {
      "ENV_VAR" = "from-archive"
    }
  }
]

lambda_archive_config = [
  {
    name         = "lambda-func-test"
    source_file  = "handler.js"
    package_name = "deployed_from_archive_terraform.zip"
  }
]
```

### Use a DockerFile
```hcl
  module "main_module" {
  source                      = "../../../../modules/lambda/lambda-function"
  is_enabled                  = var.is_enabled
  aws_region                  = var.aws_region
  lambda_config               = var.lambda_config
  lambda_archive_config       = var.lambda_archive_config
  lambda_observability_config = var.lambda_observability_config
  lambda_image_config = [
    {
      name      = "lambda-func-docker"
      image_uri = format("%s:latest", local.repository_url)
    }
  ]
  lambda_permissions_config               = var.lambda_permissions_config
  lambda_custom_policies_config           = var.lambda_custom_policies_config
  lambda_enable_eventbridge               = var.lambda_enable_eventbridge
  lambda_enable_secrets_manager           = var.lambda_enable_secrets_manager
  lambda_host_config                      = var.lambda_host_config
  lambda_network_config                   = var.lambda_network_config
  lambda_alias_config                     = var.lambda_alias_config
  lambda_s3_from_existing_config          = var.lambda_s3_from_existing_config
  lambda_s3_from_existing_new_file_config = var.lambda_s3_from_existing_new_file_config
  lambda_full_managed_config              = var.lambda_full_managed_config

  depends_on = [null_resource.docker_push]
}

/*
  * This is just for testing purposes. It's not recommended at all to delegate this task
  (pushing an image into ECR) to terraform.
  * This sort o tasks it's better to delegate them in your CICD pipeline.
*/
module "ecr" {
  source     = "github.com/Excoriate/terraform-registry-aws-containers//modules/ecr?ref=v0.17.0"
  aws_region = var.aws_region
  is_enabled = var.is_enabled
  ecr_config = [
    {
      name = "lambda-test",
    }
  ]
}

data "aws_region" "this" {
}


data "aws_caller_identity" "this" {
}


/*
  * In order to push an image, we should await a bit to the AWS API(s) to be ready.
  * This ensures that the ECR repository is ready to receive the image.
*/
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [module.ecr]
}

locals {
  repository_url = module.ecr.ecr_repository_url[0]
}

resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    /*
     * NOTE:
      - In order to avoid the below error, it's relevant to pass the platform while building the image.
      - This is because the lambda runtime is based on Amazon Linux 2, which is only available for the x86_64 architecture.
    */
    #{
    #"errorType": "Runtime.InvalidEntrypoint",
    #"errorMessage": "RequestId: 6eb1655e-07ee-48d0-915d-3c6ff34a2e47 Error: fork/exec /lambda-entrypoint.sh: exec format error"
    #}
    command = "docker build --platform linux/amd64 -t ${local.repository_url} ."
  }
}

resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${join("", data.aws_region.this.*.name)} | docker login --username AWS --password-stdin ${join("", data.aws_caller_identity.this.*.account_id)}.dkr.ecr.${join("", data.aws_region.this.*.name)}.amazonaws.com"
  }

  depends_on = [null_resource.docker_build]
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = "docker push ${local.repository_url}:latest"
  }

  depends_on = [
    time_sleep.wait_15_seconds,
    null_resource.docker_login
  ]
}
```
```hcl
  aws_region = "us-east-1"
is_enabled = true

lambda_config = [
  {
    name          = "lambda-func-docker"
    function_name = "simple-basic-function-docker"
    handler       = "handler.handler"
    deployment_type = {
      from_docker = true
    }
  }
]

lambda_observability_config = [
  {
    name         = "lambda-func-docker"
    logs_enabled = true
  }
]

lambda_permissions_config = [
  {
    name = "lambda-func-docker"
  }
]

lambda_host_config = [
  {
    name = "lambda-func-docker"
    environment_variables = {
      "ENV_VAR"  = "value"
      "ENV_VAR2" = "value2"
    }
  }
]
```

For other examples, please refer to the [examples](../../../examples) folder.

For module composition, it's recommended to take a look at the module's `outputs` to understand what's available:
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
output "lambda_config_resolved" {
  value = {
    lambda_cfg                           = local.lambda_cfg
    archive_cfg                          = local.archive_cfg
    full_managed_cfg                     = local.full_managed_cfg
    existing_s3_bucket_cfg               = local.s3_from_existing_cfg
    existing_s3_bucket_with_new_file_cfg = local.s3_from_existing_new_file_cfg
    docker_cfg                           = local.lambda_docker_cfg
  }
  description = "The resolved lambda configuration."
}

// Lambda (Existing S3 Bucket, new file) function outputs.
output "lambda_existing_s3_bucket_with_new_file_id" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.id]
  description = "The ID of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_arn" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.arn]
  description = "The ARN of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_invoke_arn" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.invoke_arn]
  description = "The invoke ARN of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_function_name" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.function_name]
  description = "The name of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_last_modified" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.last_modified]
  description = "The date Lambda (Existing S3 Bucket, new file) function was last modified."
}

output "lambda_existing_s3_bucket_with_new_file_source_code_hash" {
  value       = [for l in aws_lambda_function.from_s3_existing_new_file : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Existing S3 Bucket) function outputs.
output "lambda_existing_s3_bucket_id" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.id]
  description = "The ID of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_arn" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.arn]
  description = "The ARN of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_invoke_arn" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.invoke_arn]
  description = "The invoke ARN of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_function_name" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.function_name]
  description = "The name of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_last_modified" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.last_modified]
  description = "The date Lambda (Existing S3 Bucket, unmanaged file) function was last modified."
}

output "lambda_existing_s3_bucket_source_code_hash" {
  value       = [for l in aws_lambda_function.from_s3_existing : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}


// Lambda (Full Managed) function outputs.
output "lambda_full_managed_id" {
  value       = [for l in aws_lambda_function.full_managed : l.id]
  description = "The ID of the Lambda (Full Managed) function."
}

output "lambda_full_managed_arn" {
  value       = [for l in aws_lambda_function.full_managed : l.arn]
  description = "The ARN of the Lambda (Full Managed) function."
}

output "lambda_full_managed_invoke_arn" {
  value       = [for l in aws_lambda_function.full_managed : l.invoke_arn]
  description = "The invoke ARN of the Lambda (Full Managed) function."
}

output "lambda_full_managed_function_name" {
  value       = [for l in aws_lambda_function.full_managed : l.function_name]
  description = "The name of the Lambda (Full Managed) function."
}

output "lambda_full_managed_last_modified" {
  value       = [for l in aws_lambda_function.full_managed : l.last_modified]
  description = "The date Lambda (Full Managed) function was last modified."
}

output "lambda_full_managed_source_code_hash" {
  value       = [for l in aws_lambda_function.full_managed : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Archive) function outputs
output "lambda_archive_id" {
  value       = [for l in aws_lambda_function.from_archive : l.id]
  description = "The ID of the Lambda (Archive) function."
}

output "lambda_archive_arn" {
  value       = [for l in aws_lambda_function.from_archive : l.arn]
  description = "The ARN of the Lambda (Archive) function."
}

output "lambda_archive_invoke_arn" {
  value       = [for l in aws_lambda_function.from_archive : l.invoke_arn]
  description = "The invoke ARN of the Lambda (Archive) function."
}

output "lambda_archive_function_name" {
  value       = [for l in aws_lambda_function.from_archive : l.function_name]
  description = "The name of the Lambda (Archive) function."
}

output "lambda_archive_last_modified" {
  value       = [for l in aws_lambda_function.from_archive : l.last_modified]
  description = "The date Lambda (Archive) function was last modified."
}

output "lambda_archive_source_code_hash" {
  value       = [for l in aws_lambda_function.from_archive : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}


// Lambda (default) function outputs.
output "lambda_default_id" {
  value       = [for l in aws_lambda_function.default : l.id]
  description = "The ID of the Lambda (default) function."
}

output "lambda_default_arn" {
  value       = [for l in aws_lambda_function.default : l.arn]
  description = "The ARN of the Lambda (default) function."
}

output "lambda_default_invoke_arn" {
  value       = [for l in aws_lambda_function.default : l.invoke_arn]
  description = "The invoke ARN of the Lambda (default) function."
}

output "lambda_default_function_name" {
  value       = [for l in aws_lambda_function.default : l.function_name]
  description = "The name of the Lambda (default) function."
}

output "lambda_default_last_modified" {
  value       = [for l in aws_lambda_function.default : l.last_modified]
  description = "The date Lambda (default) function was last modified."
}

output "lambda_default_source_code_hash" {
  value       = [for l in aws_lambda_function.default : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Docker) function outputs.
output "lambda_docker_id" {
  value       = [for l in aws_lambda_function.from_docker : l.id]
  description = "The ID of the Lambda (Docker) function."
}

output "lambda_docker_arn" {
  value       = [for l in aws_lambda_function.from_docker : l.arn]
  description = "The ARN of the Lambda (Docker) function."
}

output "lambda_docker_invoke_arn" {
  value       = [for l in aws_lambda_function.from_docker : l.invoke_arn]
  description = "The invoke ARN of the Lambda (Docker) function."
}

output "lambda_docker_function_name" {
  value       = [for l in aws_lambda_function.from_docker : l.function_name]
  description = "The name of the Lambda (Docker) function."
}

output "lambda_docker_last_modified" {
  value       = [for l in aws_lambda_function.from_docker : l.last_modified]
  description = "The date Lambda (Docker) function was last modified."
}

output "lambda_docker_source_code_hash" {
  value       = [for l in aws_lambda_function.from_docker : l.source_code_hash]
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cloudwatch_logs_group_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.deploy_from_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secrets_manager_policy_rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secrets_manager_policy_rotation_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_logs_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom_policies_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.deploy_from_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secrets_manager_policy_rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secrets_manager_policy_rotation_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.from_archive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.from_docker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.from_s3_existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.from_s3_existing_new_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.full_managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.default_eventbridge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.default_secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.s3_existing_secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.managed_deployment_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.managed_deployment_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.managed_deployment_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.managed_deployment_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.managed_deployment_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.full_mode_upload_existing_zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.full_mode_upload_zip_dir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.full_mode_upload_zip_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.upload_existing_zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.upload_zip_dir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.upload_zip_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [archive_file.compress_from_dir](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [archive_file.compress_from_file](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [archive_file.from_archive_source_dir](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [archive_file.from_archive_source_file](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [archive_file.full_mode_compress_from_dir](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [archive_file.full_mode_compress_from_file](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_logs_group_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deploy_from_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets_manager_policy_rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets_manager_policy_rotation_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.s3_existing_mode_new_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_secretsmanager_secret.lookup_invoker_secret_by_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.lookup_to_rotate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [local_file.existing_zip](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/data-sources/file) | data source |
| [local_file.full_mode_existing_zip_file](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/data-sources/file) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_lambda_alias_config"></a> [lambda\_alias\_config](#input\_lambda\_alias\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- alias\_name: The name of the alias.<br>- description: The description of the alias.<br>- function\_version: The function version of the alias.<br>- routing\_config: A list of routing configurations to be applied to the alias. | <pre>list(object({<br>    name             = string<br>    alias_name       = string<br>    description      = optional(string, null)<br>    function_version = optional(string, null)<br>    routing_config = optional(list(object({<br>      additional_version_weights = optional(map(number), {})<br>    })), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_archive_config"></a> [lambda\_archive\_config](#input\_lambda\_archive\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- source\_dir: The path to the function's source code directory within the local filesystem.<br>- source\_file: The path to the function's source code file within the local filesystem.<br>- package\_name: The name of the deployment package.<br>- excluded\_files: A list of files to be excluded from the deployment package. | <pre>list(object({<br>    name           = string<br>    function_name  = optional(string, null)<br>    source_dir     = optional(string, null)<br>    source_file    = optional(string, null)<br>    package_name   = optional(string, "lambda.zip")<br>    excluded_files = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_config"></a> [lambda\_config](#input\_lambda\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- description: The description of the lambda function.<br>- publish: This boolean flag can be used to request AWS Lambda to create the Lambda function and publish a version as an atomic operation.<br>- filename: The path to the function's deployment package within the local filesystem. If defined, The s3\_bucket and s3\_key attributes will be ignored.<br>- architectures: A list of supported architectures for the function. Valid values are x86\_64 and arm64.<br>- memory\_size : The amount of memory, in MB, that is allocated to your Lambda function.<br>- handler: The function entrypoint in your code.<br>- reserved\_concurrent\_executions: The amount of reserved concurrent executions for this lambda function.<br>- runtime: The identifier of the function's runtime.<br>- layers: A list of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function.<br>- package\_type: The type of deployment package. Valid values are Zip and Image.<br>- timeout: The amount of time your Lambda Function has to run in seconds.<br>- enable\_update\_function\_on\_archive\_change: This boolean flag can be used to enable/disable the update of the lambda function when the archive changes.<br>- deployment\_type: Describe the types of lambda deployments that are supported by this module.<br>  - from\_file: This boolean flag can be used to enable/disable the deployment of the lambda function from a file.<br>  - from\_docker: This boolean flag can be used to enable/disable the deployment of the lambda function from a docker image.<br>  - from\_archive: This boolean flag can be used to enable/disable the deployment of the lambda function from an archive.<br>  - from\_s3\_existing\_file: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.<br>  - from\_s3\_existing\_new\_file: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.<br>  - full\_managed: This boolean flag can be used to enable/disable the deployment of the lambda function from an existing file in s3.<br>It's important to mention that the deployment types are mutually exclusive, so only one of them can be true. | <pre>list(object({<br>    name                           = string<br>    function_name                  = optional(string, null)<br>    description                    = optional(string, null)<br>    publish                        = optional(bool, false)<br>    filename                       = optional(string, null)<br>    architectures                  = optional(list(string), ["x86_64"])<br>    memory_size                    = optional(number, 128)<br>    handler                        = string<br>    reserved_concurrent_executions = optional(number, -1)<br>    #    provision_concurrency =optional(number, null)<br>    runtime                                  = optional(string, "nodejs18.x")<br>    layers                                   = optional(list(string), [])<br>    package_type                             = optional(string, "Zip")<br>    timeout                                  = optional(number, 3)<br>    enable_update_function_on_archive_change = optional(bool, false)<br>    // Describe the types of lambda deployments that are supported by this module.<br>    deployment_type = optional(object({<br>      from_file                 = optional(bool, false)<br>      from_docker               = optional(bool, false)<br>      from_archive              = optional(bool, false)<br>      from_s3_existing_file     = optional(bool, false)<br>      from_s3_existing_new_file = optional(bool, false)<br>      full_managed              = optional(bool, false)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_lambda_custom_policies_config"></a> [lambda\_custom\_policies\_config](#input\_lambda\_custom\_policies\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- policy\_arns: A list of policy ARNs to be attached to the lambda function. | <pre>list(object({<br>    name        = string<br>    policy_arns = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_enable_eventbridge"></a> [lambda\_enable\_eventbridge](#input\_lambda\_enable\_eventbridge) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- source\_arn: The ARN of the event source.<br>- qualifier: The qualifier of the lambda function. | <pre>list(object({<br>    name       = string<br>    source_arn = string<br>    qualifier  = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_lambda_enable_secrets_manager"></a> [lambda\_enable\_secrets\_manager](#input\_lambda\_enable\_secrets\_manager) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- secret\_arn: The ARN of the secret.<br>- secret\_name: The name of the secret.<br>- qualifier: The qualifier of the lambda function.<br>- enable\_rotation\_permissions: A boolean flag that can be used to enable/disable the permissions for the rotation of<br>the secret.<br>- enable\_rotation\_db\_permissions: A boolean flag that can be used to enable/disable the permissions for the rotation of | <pre>list(object({<br>    name        = string<br>    secret_arn  = optional(string, null)<br>    secret_name = string<br>    qualifier   = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_lambda_enable_secrets_manager_rotation"></a> [lambda\_enable\_secrets\_manager\_rotation](#input\_lambda\_enable\_secrets\_manager\_rotation) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- secrets\_to\_rotate: A list of secrets to be rotated.<br>- enable\_rotation\_db\_permissions: A boolean flag that can be used to enable/disable the permissions for the rotation of | <pre>list(object({<br>    name                           = string<br>    secrets_to_rotate              = list(string)<br>    enable_rotation_db_permissions = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_lambda_full_managed_config"></a> [lambda\_full\_managed\_config](#input\_lambda\_full\_managed\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- source\_zip\_file: The path of the zip file containing the source code of the lambda function.<br>- compress\_from\_file: The path of the file to be compressed.<br>- compress\_from\_dir: The path of the directory to be compressed.<br>- ignore\_version\_changes: This boolean flag can be used to enable/disable the update of the lambda function when the<br>version of the zip file changes.<br>- excluded\_files: A list of files to be excluded from the deployment package. | <pre>list(object({<br>    name                   = string<br>    function_name          = optional(string, null)<br>    source_zip_file        = optional(string, null)<br>    compress_from_file     = optional(string, null)<br>    compress_from_dir      = optional(string, null)<br>    ignore_version_changes = optional(bool, false)<br>    excluded_files         = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_host_config"></a> [lambda\_host\_config](#input\_lambda\_host\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- environment\_variables: A map of environment variables to be applied to the lambda function.<br>- ephemeral\_storage: The amount of ephemeral storage to be applied to the lambda function.<br>- file\_system\_config: A list of file system configurations to be applied to the lambda function. | <pre>list(object({<br>    name                  = string<br>    environment_variables = optional(map(string), {})<br>    ephemeral_storage     = optional(number, null)<br>    file_system_config = optional(list(object({<br>      local_mount_path = string<br>      arn              = string<br>    })), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_image_config"></a> [lambda\_image\_config](#input\_lambda\_image\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- image\_uri: The URI of a container image in the Amazon ECR registry.<br>- ecr\_arn: The ARN of the Amazon ECR registry that contains the image.<br>- image\_config: The configuration of the container image.<br>  - command: The command that is passed to the container.<br>  - entry\_point: The entry point that is passed to the container.<br>  - working\_directory: The working directory that is passed to the container. | <pre>list(object({<br>    name          = string<br>    function_name = optional(string, null)<br>    image_uri     = string<br>    ecr_arn       = optional(string, null)<br>    image_config = optional(list(object({<br>      command           = optional(list(string), [])<br>      entry_point       = optional(list(string), [])<br>      working_directory = optional(string, null)<br>    })), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_network_config"></a> [lambda\_network\_config](#input\_lambda\_network\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- security\_group\_ids: A list of security group IDs to be applied to the lambda function.<br>- subnet\_ids: A list of subnet IDs to be applied to the lambda function. | <pre>list(object({<br>    name               = string<br>    security_group_ids = optional(list(string), [])<br>    subnet_ids         = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_observability_config"></a> [lambda\_observability\_config](#input\_lambda\_observability\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- logs\_enabled: A boolean flag that can be used to enable/disable the logging of the lambda function.<br>- logs\_retention\_in\_days: The number of days to retain the logs of the lambda function.<br>- tracing\_enabled: A boolean flag that can be used to enable/disable the tracing of the lambda function.<br>- tracing\_mode: The tracing mode of the lambda function. The supported values are 'Active' and 'PassThrough'. | <pre>list(object({<br>    name                   = string<br>    function_name          = optional(string, null)<br>    logs_enabled           = optional(bool, false)<br>    logs_retention_in_days = optional(number, 0)<br>    tracing_enabled        = optional(bool, false)<br>    tracing_mode           = optional(string, "PassThrough")<br>  }))</pre> | `null` | no |
| <a name="input_lambda_permissions_config"></a> [lambda\_permissions\_config](#input\_lambda\_permissions\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- permissions\_boundary: The permissions boundary to be applied to the lambda function.<br>- trusted\_principals: A list of trusted principals to be applied to the lambda function. | <pre>list(object({<br>    name                 = string<br>    permissions_boundary = optional(string, null)<br>    trusted_principals   = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_lambda_s3_from_existing_config"></a> [lambda\_s3\_from\_existing\_config](#input\_lambda\_s3\_from\_existing\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- s3\_bucket: The name of the bucket where the zip file containing the source code of the lambda function is located.<br>- s3\_key: The path of the zip file containing the source code of the lambda function.<br>- s3\_object\_version: The version of the zip file containing the source code of the lambda function.<br>- ignore\_version\_changes: This boolean flag can be used to enable/disable the update of the lambda function when the<br>version of the zip file changes. | <pre>list(object({<br>    name                   = string<br>    function_name          = optional(string, null)<br>    s3_bucket              = string<br>    s3_key                 = string<br>    s3_object_version      = optional(string, null)<br>    ignore_version_changes = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_lambda_s3_from_existing_new_file_config"></a> [lambda\_s3\_from\_existing\_new\_file\_config](#input\_lambda\_s3\_from\_existing\_new\_file\_config) | A list of objects that contains the configuration for AWS Lambda function<br>The currently supported attributes are:<br>- name: The name of the lambda function. It's usually used as a terraform identifier, however, if the 'function name'<br>isn't passed, it will be used as the function name.<br>- function\_name: The name of the lambda function. If not passed, the 'name' attribute will be used.<br>- s3\_bucket: The name of the bucket where the zip file containing the source code of the lambda function is located.<br>- source\_zip\_file: The path of the zip file containing the source code of the lambda function.<br>- compress\_from\_file: The path of the file to be compressed.<br>- compress\_from\_dir: The path of the directory to be compressed.<br>- ignore\_version\_changes: This boolean flag can be used to enable/disable the update of the lambda function when the<br>version of the zip file changes.<br>- excluded\_files: A list of files to be excluded from the deployment package. | <pre>list(object({<br>    name                   = string<br>    function_name          = optional(string, null)<br>    s3_bucket              = string<br>    source_zip_file        = optional(string, null)<br>    compress_from_file     = optional(string, null)<br>    compress_from_dir      = optional(string, null)<br>    ignore_version_changes = optional(bool, false)<br>    excluded_files         = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_lambda_archive_arn"></a> [lambda\_archive\_arn](#output\_lambda\_archive\_arn) | The ARN of the Lambda (Archive) function. |
| <a name="output_lambda_archive_function_name"></a> [lambda\_archive\_function\_name](#output\_lambda\_archive\_function\_name) | The name of the Lambda (Archive) function. |
| <a name="output_lambda_archive_id"></a> [lambda\_archive\_id](#output\_lambda\_archive\_id) | The ID of the Lambda (Archive) function. |
| <a name="output_lambda_archive_invoke_arn"></a> [lambda\_archive\_invoke\_arn](#output\_lambda\_archive\_invoke\_arn) | The invoke ARN of the Lambda (Archive) function. |
| <a name="output_lambda_archive_last_modified"></a> [lambda\_archive\_last\_modified](#output\_lambda\_archive\_last\_modified) | The date Lambda (Archive) function was last modified. |
| <a name="output_lambda_archive_source_code_hash"></a> [lambda\_archive\_source\_code\_hash](#output\_lambda\_archive\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_lambda_config_resolved"></a> [lambda\_config\_resolved](#output\_lambda\_config\_resolved) | The resolved lambda configuration. |
| <a name="output_lambda_default_arn"></a> [lambda\_default\_arn](#output\_lambda\_default\_arn) | The ARN of the Lambda (default) function. |
| <a name="output_lambda_default_function_name"></a> [lambda\_default\_function\_name](#output\_lambda\_default\_function\_name) | The name of the Lambda (default) function. |
| <a name="output_lambda_default_id"></a> [lambda\_default\_id](#output\_lambda\_default\_id) | The ID of the Lambda (default) function. |
| <a name="output_lambda_default_invoke_arn"></a> [lambda\_default\_invoke\_arn](#output\_lambda\_default\_invoke\_arn) | The invoke ARN of the Lambda (default) function. |
| <a name="output_lambda_default_last_modified"></a> [lambda\_default\_last\_modified](#output\_lambda\_default\_last\_modified) | The date Lambda (default) function was last modified. |
| <a name="output_lambda_default_source_code_hash"></a> [lambda\_default\_source\_code\_hash](#output\_lambda\_default\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_lambda_docker_arn"></a> [lambda\_docker\_arn](#output\_lambda\_docker\_arn) | The ARN of the Lambda (Docker) function. |
| <a name="output_lambda_docker_function_name"></a> [lambda\_docker\_function\_name](#output\_lambda\_docker\_function\_name) | The name of the Lambda (Docker) function. |
| <a name="output_lambda_docker_id"></a> [lambda\_docker\_id](#output\_lambda\_docker\_id) | The ID of the Lambda (Docker) function. |
| <a name="output_lambda_docker_invoke_arn"></a> [lambda\_docker\_invoke\_arn](#output\_lambda\_docker\_invoke\_arn) | The invoke ARN of the Lambda (Docker) function. |
| <a name="output_lambda_docker_last_modified"></a> [lambda\_docker\_last\_modified](#output\_lambda\_docker\_last\_modified) | The date Lambda (Docker) function was last modified. |
| <a name="output_lambda_docker_source_code_hash"></a> [lambda\_docker\_source\_code\_hash](#output\_lambda\_docker\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_lambda_existing_s3_bucket_arn"></a> [lambda\_existing\_s3\_bucket\_arn](#output\_lambda\_existing\_s3\_bucket\_arn) | The ARN of the Lambda (Existing S3 Bucket, unmanaged file) function. |
| <a name="output_lambda_existing_s3_bucket_function_name"></a> [lambda\_existing\_s3\_bucket\_function\_name](#output\_lambda\_existing\_s3\_bucket\_function\_name) | The name of the Lambda (Existing S3 Bucket, unmanaged file) function. |
| <a name="output_lambda_existing_s3_bucket_id"></a> [lambda\_existing\_s3\_bucket\_id](#output\_lambda\_existing\_s3\_bucket\_id) | The ID of the Lambda (Existing S3 Bucket, unmanaged file) function. |
| <a name="output_lambda_existing_s3_bucket_invoke_arn"></a> [lambda\_existing\_s3\_bucket\_invoke\_arn](#output\_lambda\_existing\_s3\_bucket\_invoke\_arn) | The invoke ARN of the Lambda (Existing S3 Bucket, unmanaged file) function. |
| <a name="output_lambda_existing_s3_bucket_last_modified"></a> [lambda\_existing\_s3\_bucket\_last\_modified](#output\_lambda\_existing\_s3\_bucket\_last\_modified) | The date Lambda (Existing S3 Bucket, unmanaged file) function was last modified. |
| <a name="output_lambda_existing_s3_bucket_source_code_hash"></a> [lambda\_existing\_s3\_bucket\_source\_code\_hash](#output\_lambda\_existing\_s3\_bucket\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_arn"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_arn](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_arn) | The ARN of the Lambda (Existing S3 Bucket, new file) function. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_function_name"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_function\_name](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_function\_name) | The name of the Lambda (Existing S3 Bucket, new file) function. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_id"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_id](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_id) | The ID of the Lambda (Existing S3 Bucket, new file) function. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_invoke_arn"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_invoke\_arn](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_invoke\_arn) | The invoke ARN of the Lambda (Existing S3 Bucket, new file) function. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_last_modified"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_last\_modified](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_last\_modified) | The date Lambda (Existing S3 Bucket, new file) function was last modified. |
| <a name="output_lambda_existing_s3_bucket_with_new_file_source_code_hash"></a> [lambda\_existing\_s3\_bucket\_with\_new\_file\_source\_code\_hash](#output\_lambda\_existing\_s3\_bucket\_with\_new\_file\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_lambda_full_managed_arn"></a> [lambda\_full\_managed\_arn](#output\_lambda\_full\_managed\_arn) | The ARN of the Lambda (Full Managed) function. |
| <a name="output_lambda_full_managed_function_name"></a> [lambda\_full\_managed\_function\_name](#output\_lambda\_full\_managed\_function\_name) | The name of the Lambda (Full Managed) function. |
| <a name="output_lambda_full_managed_id"></a> [lambda\_full\_managed\_id](#output\_lambda\_full\_managed\_id) | The ID of the Lambda (Full Managed) function. |
| <a name="output_lambda_full_managed_invoke_arn"></a> [lambda\_full\_managed\_invoke\_arn](#output\_lambda\_full\_managed\_invoke\_arn) | The invoke ARN of the Lambda (Full Managed) function. |
| <a name="output_lambda_full_managed_last_modified"></a> [lambda\_full\_managed\_last\_modified](#output\_lambda\_full\_managed\_last\_modified) | The date Lambda (Full Managed) function was last modified. |
| <a name="output_lambda_full_managed_source_code_hash"></a> [lambda\_full\_managed\_source\_code\_hash](#output\_lambda\_full\_managed\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
