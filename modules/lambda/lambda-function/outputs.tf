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
