terraform {
  backend "s3" {
    bucket = "proyecto-devops-grupo-dos"          # Nombre de tu bucket S3
    key    = "fijos/oicd/terraform.tfstate"           # Ruta y nombre del archivo de estado dentro del bucket
    region = "eu-west-2"                           # Región donde está tu bucket S3
    encrypt = true                                   # Habilita el cifrado en el bucket
    #dynamodb_table = "mi-tabla-dynamodb"             # (Opcional) Usa DynamoDB para el bloqueo del estado (si lo deseas)
  }
}