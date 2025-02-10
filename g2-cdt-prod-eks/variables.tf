variable "tag_value" {
  description = "Tag value for naming resources"
  type        = string
  default= "Grupo2"
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
  default= "vpc-0c9f03551cb17af5d"
}

variable "subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default=["subnet-0399f98a4db137765","subnet-0b0842bc836a4b6cb","subnet-0eb5d5076276d2346"]
}

variable "instance_type" {
  description = "EC2 instance type for the EKS worker nodes"
  type        = string
  default= "t3.medium"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "desired_size" {
  description = "Desired number of worker nodes in the EKS cluster"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes in the EKS cluster"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes in the EKS cluster"
  type        = number
  default     = 1
}

variable "iam_role_additional_policies" {
  description = "Additional IAM policies to attach to the worker node IAM role"
  type = map(string)
  default = {
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    AmazonEc2FullAccess                = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    CloudWatchLogsFullAccess           = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    SecretsManagerReadWrite            = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  }
}

variable "cluster_endpoint_public_access" {
  description = "Allow public access to the EKS cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Allow private access to the EKS cluster endpoint"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "La región de AWS donde se crearán los recursos"
  type        = string
  default     = "eu-west-2"  # Región predeterminada
}
