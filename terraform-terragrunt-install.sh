#!/bin/bash

: <<'SCRIPT_USAGE' #This is a multi-line comment

curl https://raw.githubusercontent.com/godOfOps/SEA-Terragrunt/main/terraform-terragrunt-install.sh | bash

SCRIPT_USAGE

touch ~/.bashrc
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform -install-autocomplete


curl -L -o terragrunt https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin
terragrunt --install-autocomplete
source ~/.bashrc