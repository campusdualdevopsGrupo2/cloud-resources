variable "filename" {
  description = "Ruta y nombre del archivo que se va a crear"
  type        = string
}

variable "content" {
  description = "Contenido que se escribirá en el archivo"
  type        = string
}

variable "file_permission" {
  description = "Permisos del archivo (por ejemplo, '0644')"
  type        = string
  default     = "0644"
}
