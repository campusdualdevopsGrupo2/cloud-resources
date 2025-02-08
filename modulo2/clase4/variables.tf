variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"  # Cambia según la región que prefieras
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"  # Cambia según tus necesidades
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
}

variable "db_name" {
  description = "El nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
}

variable "db_password" {
  description = "Database password for RDS"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_cidr" {
  description = "CIDR block(s) allowed to SSH into the EC2 instance"
  type        = list(string)
  default     = []
}

variable "aws_db_instance_class" {
  description = "The instance class for RDS"
  type        = string
  default     = "db.t3.micro"  # Cambia según tus necesidades
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS"
  type        = number
  default     = 20  # Cambia según tus necesidades
}

variable "db_engine_version" {
  description = "Engine version for RDS"
  type        = string
  default     = "8.0"  # Cambia según la versión de MySQL que prefieras
}

