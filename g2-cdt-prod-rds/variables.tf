variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "engine" {
  description = "The database engine"
  type        = string
  default="mysql"
}

/*variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default=""
}*/

variable "instance_class" {
  description = "The instance class for the DB instance"
  type        = string
  default="db.t3.mmicro"
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

/*variable "parameter_group_name" {
  description = "The DB parameter group name"
  type        = string
}*/

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
  default= true
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the DB instance"
  type        = bool
  default= false
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default= true
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

# Variable para determinar si se debe usar múltiples zonas de disponibilidad (AZs)
variable "multi_az" {
  description = "Indica si la infraestructura debe ser desplegada en múltiples zonas de disponibilidad"
  type        = bool
  default     = false  # Valor por defecto es false (no usar múltiples AZs)
}

# Variable para especificar el tipo de almacenamiento para las instancias
variable "storage_type" {
  description = "Tipo de almacenamiento para la instancia EC2 (ej. gp2, io1)"
  type        = string
  default     = "gp2"  # Valor por defecto es gp2 (almacenamiento SSD general-purpose)
}