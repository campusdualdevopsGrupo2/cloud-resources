resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  #engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  #parameter_group_name   = var.parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot    = var.skip_final_snapshot
  deletion_protection    = var.deletion_protection
  publicly_accessible    = var.publicly_accessible
  multi_az = var.multi_az
  storage_type= var.storage_type

  tags = var.tags
}

resource "aws_db_subnet_group" "this" {
  name        = var.db_subnet_group_name
  subnet_ids  = var.subnet_ids
  description = var.subnet_group_description

  tags = var.db_subnet_group_tags
}
