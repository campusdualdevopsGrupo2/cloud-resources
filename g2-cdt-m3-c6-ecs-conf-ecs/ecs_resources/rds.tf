# ------------------------------------------------------- RDS infra  ---------------------------------




resource "aws_security_group" "rds_sg" {
  name        = "${var.tag_value}-rds-sg"
  description = "Security group for MySQL RDS"
  vpc_id      = var.vpc_id

  ingress{
    from_port   = 3306  # Puerto por defecto de MySQL
    to_port     = 3306
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups= [aws_security_group.ecs_service_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "rds-sg-${var.tag_value}"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name        = lower("my-db-subnet-group-${var.tag_value}")
  description = "Subnets for RDS instance"
  subnet_ids  = var.subnets  # Referencia a las subredes existentes

  tags = {
    Name = "MyDbSubnetGroup-${var.tag_value}"
  }
}
# Crear una base de datos MySQL usando Amazon RDS
resource "aws_db_instance" "mysql_db" {
  #count = 0
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  identifier        = lower("mymysqldb${var.tag_value}")
  engine            = "mysql"
  instance_class    = "db.t3.micro"  # Clase de instancia para MySQL
  allocated_storage = 10  # Almacenamiento en GB
  db_name           = lower("mydatabase${var.tag_value}")
  username          = var.db_username
  password          = var.db_password  # Asegúrate de usar contraseñas seguras
  skip_final_snapshot = true
  publicly_accessible = true
  multi_az          = false
  storage_type      = "gp2"
  db_subnet_group_name  = aws_db_subnet_group.my_db_subnet_group.name
  #b_subnet_group

  tags = {
    Name = "MySQLDatabase-${var.tag_value}"
  }
  depends_on = [
    aws_security_group.rds_sg        # Esperar a que el Security Group RDS se cree
  ]
}

