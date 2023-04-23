data "archive_file" "source_file" {
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
  }
}

data "archive_file" "source_dir" {
  for_each         = { for k, v in local.archive_cfg : k => v if v["source_dir"] != null }
  type             = "zip"
  source_dir       = each.value["source_dir"]
  output_file_mode = "0666"
  output_path      = each.value["package_name"]
}

data "aws_s3_bucket" "this" {
  for_each = local.s3_deploy_cfg
  bucket   = each.value["s3_bucket"]
}
