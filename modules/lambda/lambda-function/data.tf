data "archive_file" "from_archive_source_file" {
  for_each         = { for k, v in local.archive_cfg : k => v if v["source_file"] != null }
  type             = "zip"
  source_file      = each.value["source_file"]
  output_file_mode = "0666"
  output_path      = each.value["package_name"]

  lifecycle {
    precondition {
      condition     = fileexists(each.value["source_file"]) && contains([".js", ".py", ".go", ".jar", ".sh", ".bash", ".rs", ".java", ".cs"], substr(each.value["source_file"], -3, 3))
      error_message = "The file ${each.value["source_file"]} does not exist or does not have one of the allowed extensions to be zipped (.js, .py, .go, .jar, .sh, .bash, .rs, .java, .cs)"
    }

    precondition {
      condition     = contains([".zip"], substr(each.value["package_name"], -4, 4))
      error_message = "The file ${each.value["package_name"]} does not exist or is not a file"
    }

    precondition {
      condition     = each.value["excluded_files"] == null
      error_message = "The option 'excluded_files' is not allowed for the source_file option"
    }
  }
}

data "archive_file" "from_archive_source_dir" {
  for_each         = { for k, v in local.archive_cfg : k => v if v["source_dir"] != null }
  type             = "zip"
  source_dir       = each.value["source_dir"]
  output_file_mode = "0666"
  output_path      = each.value["package_name"]
  excludes         = each.value["excluded_files"]
}

/*
* -----------------------------------
* S3 related datasources
* -----------------------------------
*/
data "aws_s3_bucket" "s3_existing_mode_existing_file" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_file"] }
  bucket   = lookup(local.s3_from_existing_cfg[each.key], "s3_bucket")
}

data "aws_s3_bucket" "s3_existing_mode_new_file" {
  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] }
  bucket   = lookup(local.s3_from_existing_new_file_cfg[each.key], "s3_bucket")
}

data "local_file" "existing_zip" {
  #  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "use_zip_file", false) }
  for_each = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "use_zip_file", false) }
  filename = lookup(local.s3_from_existing_new_file_cfg[each.key], "source_zip_file")
}

data "archive_file" "compress_from_file" {
  #  for_each         = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && length(keys(local.s3_from_existing_new_file_cfg)) != 0 && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_file", false) }
  for_each         = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_file", false) }
  type             = "zip"
  output_file_mode = "0666"
  output_path      = "generated-zip-from-file-${each.key}.zip"
  source_file      = lookup(local.s3_from_existing_new_file_cfg[each.key], "compress_from_file")
}

data "archive_file" "compress_from_dir" {
  #  for_each         = { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_dir", false) }
  for_each         = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_from_s3_existing_new_file"] && lookup(local.s3_from_existing_new_file_cfg[k], "generate_zip_from_dir", false) }
  type             = "zip"
  output_file_mode = "0666"
  output_path      = "generated-zip-from-dir-${each.key}.zip"
  excludes         = lookup(local.s3_from_existing_new_file_cfg[each.key], "excluded_files", null)
  source_dir       = lookup(local.s3_from_existing_new_file_cfg[each.key], "compress_from_dir")
}

/*
 * ---------------------------------------
 * Full managed mode
 * ---------------------------------------
*/
data "local_file" "full_mode_existing_zip_file" {
  #  for_each = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "use_zip_file", false) }
  for_each = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "use_zip_file", false) }
  filename = lookup(local.full_managed_cfg[each.key], "source_zip_file")
}

data "archive_file" "full_mode_compress_from_file" {
  #  for_each         = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_file", false) }
  for_each         = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_file", false) }
  type             = "zip"
  output_file_mode = "0666"
  output_path      = "full-mode-generated-zip-from-file-${each.key}.zip"
  source_file      = lookup(local.full_managed_cfg[each.key], "compress_from_file")
}

data "archive_file" "full_mode_compress_from_dir" {
  #  for_each         = { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_dir", false) }
  for_each         = length(keys({ for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] })) == 0 ? {} : { for k, v in local.lambda_cfg : k => v if v["enabled_full_managed"] && lookup(local.full_managed_cfg[k], "generate_zip_from_dir", false) }
  type             = "zip"
  output_file_mode = "0666"
  output_path      = "full-mode-generated-zip-from-dir-${each.key}.zip"
  excludes         = lookup(local.full_managed_cfg[each.key], "excluded_files", null)
  source_dir       = lookup(local.full_managed_cfg[each.key], "compress_from_dir")
}
