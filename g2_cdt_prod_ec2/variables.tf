variable "ami" {
  description = "The ID of the AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the instance"
  type        = list(string)
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "provisioning_commands" {
  description = "Commands to execute on the instance after it starts"
  type        = list(string)
  default     = []
}

variable "ssh_user" {
  description = "The SSH user to connect to the EC2 instance"
  type        = string
  default     = "ubuntu" 
}

variable "private_key" {
  description = "The private SSH key to use for the connection"
  type        = string
}
