resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  # Iterate over the provisioners to add them dynamically
  dynamic "provisioner" {
    for_each = var.provisioners
    content {
      type = provisioner.value.type

      inline = provisioner.value.inline
      script = provisioner.value.script
      path   = provisioner.value.path

      connection {
        type        = "ssh"
        host        = self.public_ip
        user        = var.ssh_user
        private_key = var.private_key
      }

      local-exec = provisioner.value.local_exe
    }
  }
}
