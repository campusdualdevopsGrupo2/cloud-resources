resource "null_resource" "generic_command" {
  # El trigger se usa para ejecutar el recurso solo cuando ciertas condiciones cambian.
  triggers = {
    command_hash = sha256(var.command)
  }

  provisioner "local-exec" {
    command     = var.command
    working_dir = var.working_directory

    environment = var.env_vars
  }
}