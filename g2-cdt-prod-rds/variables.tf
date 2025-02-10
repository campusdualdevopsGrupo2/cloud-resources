variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "engine" {
  description = "The database engine"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the DB instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The master username for the DB instance"
  type        = string
}

variable "password" {
  description = "The master password for the DB instance"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "The DB parameter group name"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the DB instance"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the DB instance"
  type        = bool
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the DB instance"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}

variable "tags" {
  description = "A map of tags to assign to the DB instance"
  type        = map(string)
}

variable "subnet_group_description" {
  description = "The description for the DB subnet group"
  type        = string
  default     = "Default DB subnet group"
}

variable "db_subnet_group_tags" {
  description = "A map of tags to assign to the DB subnet group"
  type        = map(string)
}
