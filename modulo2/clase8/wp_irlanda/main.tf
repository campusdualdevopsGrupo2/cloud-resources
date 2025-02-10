terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.2"
    }
  }
}

provider "aws" {
  region = var.region
}

# Data source para obtener la IP pública de la máquina que ejecuta GitHub Actions
data "http" "my_ip" {
  url = "https://api.ipify.org"
}

locals {
  my_public_ip = trimspace(data.http.my_ip.response_body)
  my_public_ip_cidr  = "${local.my_public_ip}/32"
  effective_allowed_ssh_cidr = length(var.allowed_ssh_cidr) > 0 ? var.allowed_ssh_cidr : [local.my_public_ip_cidr]
}


###############################
# Generar la clave SSH internamente
###############################

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key_file" {
  filename        = "${path.module}/generated_key.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

###############################
# Creación de la infraestructura
###############################

resource "aws_security_group" "wordpress_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for WordPress: allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.effective_allowed_ssh_cidr
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wordpress" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Esperando que la instancia responda por SSH...'"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
    }
  }
}

###############################
# Crear un grupo de subredes para RDS
###############################

resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "wordpress-db-subnet-group-g2"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "WordPress DB Subnet Group"
  }
}

###############################
# Crear un grupo de seguridad para RDS
###############################

resource "aws_security_group" "wordpress_db_sg" {
  name        = "wordpress-db-sg-g2"
  description = "Security group for WordPress RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow MySQL/Aurora access from WordPress instance"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.wordpress_sg.id]  # Usar el grupo de seguridad de WordPress
  }
  

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###############################
# Crear la instancia de RDS
###############################

resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  identifier          = "wordpress-db"
  username            = var.db_username
  password            = var.db_password
  db_name             = var.db_name 
  db_subnet_group_name = aws_db_subnet_group.wordpress_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.wordpress_db_sg.id]
  skip_final_snapshot = true

  tags = {
    Name = "WordPress DB"
  }
}

###############################
# Generar el archivo de inventario para Ansible
###############################

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/hosts.ini"
  content  = <<-EOT
    [wordpress]
    ${aws_instance.wordpress.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${path.module}/generated_key.pem
  EOT
}


###############################
# Provisión con Ansible usando el inventario generado
###############################

resource "null_resource" "ansible_provision" {
  depends_on = [aws_instance.wordpress, local_file.ansible_inventory, aws_db_instance.wordpress_db]

  provisioner "local-exec" {
    command = <<EOT
      ANSIBLE_SSH_EXTRA_ARGS="-o StrictHostKeyChecking=no" \
      ansible-playbook -i ${path.module}/ansible/hosts.ini \
      ${path.module}/ansible/install_wordpress.yml \
      --extra-vars 'db_name=${var.db_name} db_username=${var.db_username} db_password=${var.db_password} db_endpoint=${aws_db_instance.wordpress_db.address}'
    EOT
  }
}



