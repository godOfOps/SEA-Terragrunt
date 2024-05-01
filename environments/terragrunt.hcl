remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "sea-terragrunt-terraform-state"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "sea-terraform-lock-table"
    s3_bucket_tags = {
      "Created_by" = "Terragrunt"
    }
    dynamodb_table_tags = {
      "Created_by" = "Terragrunt"
    }
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF

provider "aws" {
  region  = "us-west-2"

}
EOF
}