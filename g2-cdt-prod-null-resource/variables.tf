variable "command" {
  description = "El comando que se ejecutará como parte del recurso null."
  type        = string
}

variable "working_directory" {
  description = "El directorio de trabajo en el que se ejecutará el comando."
  type        = string
  default     = "."  # Por defecto, ejecutará en el directorio actual.
}

variable "env_vars" {
  description = "Variables de entorno a pasar al comando."
  type        = map(string)
  default     = {}
}