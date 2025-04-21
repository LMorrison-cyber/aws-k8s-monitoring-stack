module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"  # or any 20.x.x version
  cluster_name    = "aws-k8s-monitoring-cluster"
  cluster_version = "1.29"

  # VPC and Subnet Information
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  # Enable cluster creator admin permissions
  enable_cluster_creator_admin_permissions = true

  # Node Group Configuration (if needed)
  # Example for managed node groups, customize as per your needs:
  # node_groups = {
  #   eks_nodes = {
  #     desired_capacity = 2
  #     max_capacity     = 3
  #     min_capacity     = 1
  #     instance_type    = "t3.medium"
  #     key_name         = var.key_name
  #   }
  # }
}

# Manually create the aws-auth ConfigMap in Kubernetes (after cluster creation)
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = "arn:aws:iam::430523330231:user/terraform-user"  # Ensure this role exists
        username = "eks-admin"
        groups   = ["system:masters"]
      }
    ])
    mapUsers = jsonencode([
      {
        userarn  = "arn:aws:iam::430523330231:user/terraform-user"
        username = "eks-admin"
        groups   = ["system:masters"]
      }
    ])
    mapAccounts = jsonencode([
      "430523330231"
    ])
  }
}

