output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "lambda_config_resolved" {
  value       = module.main_module.lambda_config_resolved
  description = "The resolved lambda configuration."
}

// Lambda (Existing S3 Bucket, new file) function outputs.
output "lambda_existing_s3_bucket_with_new_file_id" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_id
  description = "The ID of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_arn" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_arn
  description = "The ARN of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_invoke_arn" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_invoke_arn
  description = "The invoke ARN of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_function_name" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_function_name
  description = "The name of the Lambda (Existing S3 Bucket, new file) function."
}

output "lambda_existing_s3_bucket_with_new_file_last_modified" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_last_modified
  description = "The date Lambda (Existing S3 Bucket, new file) function was last modified."
}

output "lambda_existing_s3_bucket_with_new_file_source_code_hash" {
  value       = module.main_module.lambda_existing_s3_bucket_with_new_file_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Existing S3 Bucket) function outputs.
output "lambda_existing_s3_bucket_id" {
  value       = module.main_module.lambda_existing_s3_bucket_id
  description = "The ID of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_arn" {
  value       = module.main_module.lambda_existing_s3_bucket_arn
  description = "The ARN of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_invoke_arn" {
  value       = module.main_module.lambda_existing_s3_bucket_invoke_arn
  description = "The invoke ARN of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_function_name" {
  value       = module.main_module.lambda_existing_s3_bucket_function_name
  description = "The name of the Lambda (Existing S3 Bucket, unmanaged file) function."
}

output "lambda_existing_s3_bucket_last_modified" {
  value       = module.main_module.lambda_existing_s3_bucket_last_modified
  description = "The date Lambda (Existing S3 Bucket, unmanaged file) function was last modified."
}

output "lambda_existing_s3_bucket_source_code_hash" {
  value       = module.main_module.lambda_existing_s3_bucket_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}


// Lambda (Full Managed) function outputs.
output "lambda_full_managed_id" {
  value       = module.main_module.lambda_full_managed_id
  description = "The ID of the Lambda (Full Managed) function."
}

output "lambda_full_managed_arn" {
  value       = module.main_module.lambda_full_managed_arn
  description = "The ARN of the Lambda (Full Managed) function."
}

output "lambda_full_managed_invoke_arn" {
  value       = module.main_module.lambda_full_managed_invoke_arn
  description = "The invoke ARN of the Lambda (Full Managed) function."
}

output "lambda_full_managed_function_name" {
  value       = module.main_module.lambda_full_managed_function_name
  description = "The name of the Lambda (Full Managed) function."
}

output "lambda_full_managed_last_modified" {
  value       = module.main_module.lambda_full_managed_last_modified
  description = "The date Lambda (Full Managed) function was last modified."
}

output "lambda_full_managed_source_code_hash" {
  value       = module.main_module.lambda_full_managed_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Archive) function outputs
output "lambda_archive_id" {
  value       = module.main_module.lambda_archive_id
  description = "The ID of the Lambda (Archive) function."
}

output "lambda_archive_arn" {
  value       = module.main_module.lambda_archive_arn
  description = "The ARN of the Lambda (Archive) function."
}

output "lambda_archive_invoke_arn" {
  value       = module.main_module.lambda_archive_invoke_arn
  description = "The invoke ARN of the Lambda (Archive) function."
}

output "lambda_archive_function_name" {
  value       = module.main_module.lambda_archive_function_name
  description = "The name of the Lambda (Archive) function."
}

output "lambda_archive_last_modified" {
  value       = module.main_module.lambda_archive_last_modified
  description = "The date Lambda (Archive) function was last modified."
}

output "lambda_archive_source_code_hash" {
  value       = module.main_module.lambda_archive_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}


// Lambda (default) function outputs.
output "lambda_default_id" {
  value       = module.main_module.lambda_default_id
  description = "The ID of the Lambda (default) function."
}

output "lambda_default_arn" {
  value       = module.main_module.lambda_default_arn
  description = "The ARN of the Lambda (default) function."
}

output "lambda_default_invoke_arn" {
  value       = module.main_module.lambda_default_invoke_arn
  description = "The invoke ARN of the Lambda (default) function."
}

output "lambda_default_function_name" {
  value       = module.main_module.lambda_default_function_name
  description = "The name of the Lambda (default) function."
}

output "lambda_default_last_modified" {
  value       = module.main_module.lambda_default_last_modified
  description = "The date Lambda (default) function was last modified."
}

output "lambda_default_source_code_hash" {
  value       = module.main_module.lambda_default_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}

// Lambda (Docker) function outputs.
output "lambda_docker_id" {
  value       = module.main_module.lambda_docker_id
  description = "The ID of the Lambda (Docker) function."
}

output "lambda_docker_arn" {
  value       = module.main_module.lambda_docker_arn
  description = "The ARN of the Lambda (Docker) function."
}

output "lambda_docker_invoke_arn" {
  value       = module.main_module.lambda_docker_invoke_arn
  description = "The invoke ARN of the Lambda (Docker) function."
}

output "lambda_docker_function_name" {
  value       = module.main_module.lambda_docker_function_name
  description = "The name of the Lambda (Docker) function."
}

output "lambda_docker_last_modified" {
  value       = module.main_module.lambda_docker_last_modified
  description = "The date Lambda (Docker) function was last modified."
}

output "lambda_docker_source_code_hash" {
  value       = module.main_module.lambda_docker_source_code_hash
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
}
