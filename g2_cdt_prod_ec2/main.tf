resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  # Optional: Add a provisioner or other resources like EBS volumes here
  provisioner "remote-exec" {
    inline = var.provisioning_commands

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.ssh_user
      private_key = var.private_key
    }
  }
}
