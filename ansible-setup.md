# Ansible Setup
The ansible setup described here installs Apache httpd webserver and deploys a web application from a Github Repository. Here are some highlights of this setup:
* Dynamic Inventory creation based on AutoScaling Group Tags
* Dynamically generated temporary ssh keys for connecting to EC2 Instances using AWS EC2 Instance Connect Endpoints. Here are the Benefits:
    * Temporary SSH Keys become invalid if not used within 60s
    * No bastion/jump server required in Public Subnet
    * No SSH ports open to Internet
    * No use of root Keypair for authenticating to EC2 Instances (Infact no Keypair attached to any EC2)
* Run Playbook from **ANYWHERE**.

## Pre-requisites:
* System should have the following installed:
    * aws-cli(v2)
    * python3, python3-pip
    * ansible
    * boto, botocore, boto3
    * amazon.aws collection
    ```
    sudo yum install python3 python3-pip -y
    pip3 install ansible boto botocore boto3
    ansible-galaxy collection install amazon.aws
    sudo yum remove awscli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
    ```
* IAM User/IAM Role should have atleast the following permissions:
    * autoscaling:Describe*
    * autoscaling:Get*
    * ec2:Describe*
    * ec2:Get*
    * ec2:AuthorizeSecurityGroupIngress
    * ec2-instance-connect:OpenTunnel
    * ec2-instance-connect:SendSSHPublicKey

## Run Ansible Playbook:

* In [ansible-manage-web-servers.yml](ansible-manage-web-servers.yml), modify the variables as per your setup. Also update the Autoscaling Group Tags on line 23.
* If you are using Access Keys/Secret Keys, configure them for ansible to discover them.
* Run the playbook with command:
    ```
    ansible-playbook -v ansible-manage-web-servers.yml
    ```