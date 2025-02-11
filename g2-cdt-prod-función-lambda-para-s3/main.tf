# Creación del rol IAM para la función Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Principal = { Service = "lambda.amazonaws.com" },
      Effect    = "Allow"
    }]
  })
}

# Adjuntar la política básica de ejecución para Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Creación de la función Lambda
resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  runtime       = var.runtime
  handler       = var.handler

  # Se asigna el rol creado anteriormente
  role = aws_iam_role.lambda_role.arn

  # Se agrega dependencia para asegurarse que el rol y su política estén creados
  depends_on = [aws_iam_role_policy_attachment.lambda_basic_execution]
}
