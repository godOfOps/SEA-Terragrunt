terraform {
  source = "git::git@github.com:godOfOps/SEA-terraform-modules.git//ec2?ref=main"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env                      = include.env.locals.env
  vpc_id                   = dependency.vpc.outputs.vpc_id
  public_subnet_ids        = dependency.vpc.outputs.public_subnet_ids
  private_subnet_ids       = dependency.vpc.outputs.private_subnet_ids
  ingress_ports_elb        = [80, 443]
  ingress_ports_ec2        = [80]
  instance_type            = "t2.micro"
  instance_keypair         = "sea-kp"
  volume_size              = 10   # Secondary EBS Volume size in GB
  average_cpu_util         = 70.0 # Average CPU Utilization to trigger ASG Scaling action
  request_count_per_target = 10.0 # Average Request Count Per Target to trigger ASG Scaling action
  scaling_config = {
    min_size         = 2
    max_size         = 5
    desired_capacity = 2
  }
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "vpc-1234"
    private_subnet_ids = ["pub-subnet-1234", "pub-subnet-5678"]
    public_subnet_ids = ["pri-subnet-1234", "pri-subnet-5678"]
  }
}