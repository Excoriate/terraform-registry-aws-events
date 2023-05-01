/*
 * ---------------------------------------
 * S3 existing bucket & new file capability
 * ---------------------------------------
*/
resource "aws_s3_object" "upload_zip_file" {
  #  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_file", false) }
  for_each = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_file", false) }
  source   = data.archive_file.compress_from_file[each.key].output_path
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.archive_file.compress_from_file[each.key].output_path)

  depends_on = [data.archive_file.compress_from_file, data.aws_s3_bucket.s3_existing_mode_new_file]
}

resource "aws_s3_object" "upload_zip_dir" {
  #  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_dir", false) }
  for_each = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_dir", false) }
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.archive_file.compress_from_dir[each.key].output_path)
  source   = data.archive_file.compress_from_dir[each.key].output_path

  depends_on = [data.archive_file.compress_from_dir, data.aws_s3_bucket.s3_existing_mode_new_file]
}

resource "aws_s3_object" "upload_existing_zip" {
  #  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "use_zip_file", false) }
  for_each = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "use_zip_file", false) }
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.local_file.existing_zip[each.key].filename)
  source   = data.local_file.existing_zip[each.key].filename

  depends_on = [data.aws_s3_bucket.s3_existing_mode_new_file, data.local_file.existing_zip]
}

/*
 * ---------------------------------------
 * Full managed mode
 * ---------------------------------------
*/
resource "aws_s3_bucket" "managed_deployment_bucket" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] }
  force_destroy = true
  bucket        = lower(format("lambda-deployment-bucket-%s", each.key))
}

resource "aws_s3_bucket_versioning" "managed_deployment_bucket" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] }
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "managed_deployment_bucket" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] }
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "managed_deployment_bucket" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] }
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  rule {
    id     = "lambda-deployment-lifecycle"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 180
    }
  }
}

resource "aws_s3_bucket_public_access_block" "managed_deployment_bucket" {
  for_each                = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] }
  bucket                  = aws_s3_bucket.managed_deployment_bucket[each.key].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "full_mode_upload_zip_file" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_file", false) }
  source   = data.archive_file.full_mode_compress_from_file[each.key].output_path
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  key      = format("managed-deployment/function-%s/%s", each.key, data.archive_file.full_mode_compress_from_file[each.key].output_path)

  depends_on = [data.archive_file.full_mode_compress_from_file, aws_s3_bucket.managed_deployment_bucket]
}

resource "aws_s3_object" "full_mode_upload_zip_dir" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_dir", false) }
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  key      = format("managed-deployment/function-%s/%s", each.key, data.archive_file.full_mode_compress_from_dir[each.key].output_path)
  source   = data.archive_file.full_mode_compress_from_dir[each.key].output_path

  depends_on = [data.archive_file.full_mode_compress_from_dir, aws_s3_bucket.managed_deployment_bucket]
}

resource "aws_s3_object" "full_mode_upload_existing_zip" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "use_zip_file", false) }
  bucket   = aws_s3_bucket.managed_deployment_bucket[each.key].id
  key      = format("managed-deployment/function-%s/%s", each.key, data.local_file.full_mode_existing_zip_file[each.key].filename)
  source   = data.local_file.full_mode_existing_zip_file[each.key].filename

  depends_on = [data.local_file.full_mode_existing_zip_file, aws_s3_bucket.managed_deployment_bucket]
}
