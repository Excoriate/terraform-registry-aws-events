data "archive_file" "s3_existing_bucket_zip_file" {
  for_each         = { for k, v in local.s3_deploy_cfg : k => v if v["is_zip_to_be_generated_from_file"] }
  type             = "zip"
  source_file      = each.value["source_file"]
  output_file_mode = "0666"
  output_path      = "lambda.zip"

  lifecycle {
    precondition {
      condition     = fileexists(each.value["source_file"]) && contains([".js", ".py", ".go", ".jar", ".sh", ".bash", ".rs", ".java", ".cs"], substr(each.value["source_file"], -3, 3))
      error_message = "The file ${each.value["source_file"]} does not exist or does not have one of the allowed extensions to be zipped (.js, .py, .go, .jar, .sh, .bash, .rs, .java, .cs)"
    }
  }
}

data "archive_file" "s3_existing_bucket_zip_dir" {
  for_each         = { for k, v in local.s3_deploy_cfg : k => v if v["is_zip_to_be_generated_from_dir"] }
  type             = "zip"
  source_dir       = each.value["source_dir"]
  output_file_mode = "0666"
  output_path      = "lambda.zip"
}

data "aws_s3_bucket" "this" {
  for_each = local.s3_deploy_cfg
  bucket   = each.value["s3_bucket"]
}

resource "random_string" "this" {
  for_each = local.s3_deploy_cfg
  length   = 8
  special  = false
}


resource "aws_s3_object" "lambda_archive_from_existing_zip" {
  for_each = { for k, v in local.s3_deploy_cfg : k => v if v["is_existing_zip_file"] }
  bucket   = data.aws_s3_bucket.this[each.key].id
  key      = "deployment/${each.value["name"]}/id-${random_string.this[each.key].result}/lambda.zip"
  source   = each.value["source_zip_file"]
}

resource "aws_s3_object" "lambda_archive_from_managed_zip_from_file" {
  for_each = { for k, v in local.s3_deploy_cfg : k => v if v["is_zip_to_be_generated_from_file"] }
  bucket   = data.aws_s3_bucket.this[each.key].id
  key      = "deployment/${each.value["name"]}/id-${random_string.this[each.key].result}/lambda.zip"
  source   = data.archive_file.s3_existing_bucket_zip_file[each.key].output_path
}

resource "aws_s3_object" "lambda_archive_from_managed_zip_from_dir" {
  for_each = { for k, v in local.s3_deploy_cfg : k => v if v["is_zip_to_be_generated_from_dir"] }
  bucket   = data.aws_s3_bucket.this[each.key].id
  key      = "deployment/${each.value["name"]}/id-${random_string.this[each.key].result}/lambda.zip"
  source   = data.archive_file.s3_existing_bucket_zip_dir[each.key].output_path
}
