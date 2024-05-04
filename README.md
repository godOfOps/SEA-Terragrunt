# SEA-Terragrunt

## Pre-requisites:
* Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* Install [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

* Generate ssh key and add to Github account(This key will be used by Terragrunt to pull Terraform Modules via ssh)
    * [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)
    * [Adding a new SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account)
* Make sure the Machine has the correct IAM permissions or Access Keys/Secret Keys have been configured
## Run Terragrunt
* Clone this git repository and go to the environment folder:
    ```
    git clone https://github.com/godOfOps/SEA-Terragrunt.git
    cd SEA-Terragrunt/environments/dev
    ```
* Run Terragrunt init, plan, apply
    ```
    terragrunt run-all init 
    terragrunt run-all init --terragrunt-source-update # If you want to refresh terragrunt cache
    terragrunt run-all plan
    terragrunt run-all apply
    ```
* Terragrunt will **auto-create the S3 Buckets and DynamoDB Table** to maintain the trraform state file and provision the infrastructure.

# Ansible Setup:
Ansible Playbook setup configure/deploy Web Application in ASG EC2 Instances is [here](ansible-setup.md)
