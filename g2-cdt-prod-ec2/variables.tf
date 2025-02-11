variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  default="ami-06e02ae7bdac6b938"
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
  default="t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "ssh_user" {
  description = "SSH username for remote execution"
  type        = string
}

variable "private_key" {
  description = "Private key for SSH access"
  type        = string
}

variable "provisioners" {
  description = "List of provisioners to run on the instance"
  type = list(object({
    type    = string
    inline  = list(string)
    script  = string
    path    = string
    local_exe = string
  }))
  default = []
}