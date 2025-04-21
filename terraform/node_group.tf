
#node_group.tf


resource "aws_eks_node_group" "default" {
  cluster_name    = module.eks.cluster_name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"
  disk_size      = 20

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  tags = {
    Name = "eks-node-group"
  }

  depends_on = [aws_iam_role_policy_attachment.worker_node_AmazonEKSWorkerNodePolicy]
}

