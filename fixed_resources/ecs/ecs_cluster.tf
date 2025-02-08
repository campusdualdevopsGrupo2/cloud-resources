provider "aws" {
  region = local.aws_region  # Usamos una variable para la región, que podemos definir en variables.tf

}
locals {
  tag_value="Grupo2"
  aws_region = "eu-west-2" 
}


locals {
  vpc_id = "vpc-0c9f03551cb17af5d" #vpc default
  subnets = ["subnet-0399f98a4db137765","subnet-0b0842bc836a4b6cb","subnet-0eb5d5076276d2346"]

}


terraform {
  backend "s3" {
    bucket = "proyecto-devops-grupo-dos"          # Nombre de tu bucket S3
    key    = "ecs/terraform.tfstate"           # Ruta y nombre del archivo de estado dentro del bucket
    region = "eu-west-2"                           # Región donde está tu bucket S3
    encrypt = true                                   # Habilita el cifrado en el bucket
    #dynamodb_table = "mi-tabla-dynamodb"             # (Opcional) Usa DynamoDB para el bloqueo del estado (si lo deseas)
  }
}

resource "aws_ecs_cluster" "mi_ecs" {
    name = "${local.tag_value}-cluster"
        setting {
            name = "containerInsights"
            value = "disabled"
        }
    tags = {
        Team = "Devops-bootcamp-${local.tag_value}"
    }
}

output "ecs_cluster_id" {
  description = "El ID del clúster ECS creado"
  value       = aws_ecs_cluster.mi_ecs.id
}

output "ecs_cluster_name" {
  description = "El nombre del clúster ECS creado"
  value       = aws_ecs_cluster.mi_ecs.name
}

output "vpc_id" {
  description = "El ID de la VPC donde se encuentra el ECS"
  value       = local.vpc_id
}

output "subnets" {
  description = "Las subnets asociadas al ECS"
  value       = local.subnets
}

