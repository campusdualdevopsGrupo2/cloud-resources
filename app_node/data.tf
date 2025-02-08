data "terraform_remote_state" "ecs" {
  backend = "s3"  # Usa el mismo backend S3 configurado en el proyecto EKS

  config = {
    bucket = "proyecto-devops-grupo-dos"
    key    = "ecs/terraform.tfstate"
    region = "eu-west-2"
  }

}

locals{
    tag_value="Grupo2"
    aws_region="eu-west-2"
    cluster_id= data.terraform_remote_state.ecs.outputs.ecs_cluster_id
    vpc_id=data.terraform_remote_state.ecs.outputs.vpc_id
    subnets= data.terraform_remote_state.ecs.outputs.subnets

}

terraform {
  backend "s3" {
    bucket = "proyecto-devops-grupo-dos"          # Nombre de tu bucket S3
    key    = "ecs/app_node/terraform.tfstate"           # Ruta y nombre del archivo de estado dentro del bucket
    region = "eu-west-2"                           # Región donde está tu bucket S3
    encrypt = true                                   # Habilita el cifrado en el bucket
    #dynamodb_table = "mi-tabla-dynamodb"             # (Opcional) Usa DynamoDB para el bloqueo del estado (si lo deseas)
  }
}