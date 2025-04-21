# terraform.tfvars

cluster_name           = "aws-k8s-monitoring-cluster"
cluster_version        = "1.29"
aws_region             = "us-east-1"

vpc_id                 = "vpc-03da71dc4bd8e2c02"  # Replace with your actual VPC ID
subnet_ids             = ["subnet-0a4976b61535ab9ee", "subnet-0f125655f5d1fa9cd"]  # Replace with your actual Subnet IDs
control_plane_subnet_ids = ["subnet-094ecf0a974819d4c", "subnet-04864510bd1668fe4"]  # Replace with your actual Subnet IDs

# EKS AWS Auth Configuration
aws_auth_roles = [
  {
    rolearn  = "arn:aws:iam::430523330231:role/terraform-user"  # Replace with your actual IAM role ARN
    username = "eks-admin"
    groups   = ["system:masters"]  # Grants admin access to the EKS cluster
  }
]

aws_auth_users = [
  {
    userarn  = "arn:aws:iam::430523330231:user/terraform-user"  # Replace with your actual IAM user ARN
    username = "eks-admin"
    groups   = ["system:masters"]  # Grants admin access to the EKS cluster
  }
]

aws_auth_accounts = ["430523330231"]  # Your AWS Account ID

private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

vpc_cidr = "10.0.0.0/16"

node_group_role_arn = "arn:aws:iam::430523330231:user/terraform-user"
ec2_ssh_key         = "eks-key"
private_subnet_ids  = ["subnet-094ecf0a974819d4c", "subnet-04864510bd1668fe4"]

