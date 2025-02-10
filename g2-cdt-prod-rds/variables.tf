variable "allocated_storage" {
  description = "Almacenamiento asignado en GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "Motor de base de datos"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Clase de instancia de RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "username" {
  description = "Nombre de usuario para la base de datos"
  type        = string
}

variable "password" {
  description = "Contraseña para la base de datos"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "Nombre del grupo de parámetros a asociar"
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "Nombre del grupo de subredes para la base de datos"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "IDs de grupos de seguridad VPC a asociar"
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Omitir snapshot final al eliminar la instancia"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Habilitar protección de eliminación"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Determina si la instancia es públicamente accesible"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para la instancia"
  type        = map(string)
  default     = {}
}
