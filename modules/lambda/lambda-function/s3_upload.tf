resource "aws_s3_object" "upload_zip_file" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_file", false) }
  source   = data.archive_file.compress_from_file[each.key].output_path
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.archive_file.compress_from_file[each.key].output_path)

  depends_on = [data.archive_file.compress_from_file, data.aws_s3_bucket.s3_existing_mode_new_file]
}

resource "aws_s3_object" "upload_zip_dir" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_dir", false) }
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.archive_file.compress_from_dir[each.key].output_path)
  source   = data.archive_file.compress_from_dir[each.key].output_path

  depends_on = [data.archive_file.compress_from_dir, data.aws_s3_bucket.s3_existing_mode_new_file]
}

resource "aws_s3_object" "upload_existing_zip" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "use_zip_file", false) }
  bucket   = data.aws_s3_bucket.s3_existing_mode_new_file[each.key].id
  key      = format("deployment-function-%s/%s", each.key, data.local_file.existing_zip[each.key].filename)
  source   = data.local_file.existing_zip[each.key].filename

  depends_on = [data.aws_s3_bucket.s3_existing_mode_new_file, data.local_file.existing_zip]
}
