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
