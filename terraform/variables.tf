# Cluster settings
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnets used by the EKS control plane"
  type        = list(string)
}

# Optional custom subnet CIDRs for VPC creation (if you're creating your own VPC)
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# AWS Auth ConfigMap
variable "aws_auth_roles" {
  description = "List of IAM roles to add to aws-auth configmap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "List of IAM users to add to aws-auth configmap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_accounts" {
  description = "List of AWS account IDs to add to aws-auth configmap"
  type        = list(string)
  default     = []
}

variable "node_group_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}

variable "ec2_ssh_key" {
  description = "Name of the EC2 SSH key pair"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the node group"
  type        = list(string)
}

