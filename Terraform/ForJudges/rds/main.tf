resource "aws_db_subnet_group" "this" {
  name       = "this-subnet-group"
  subnet_ids = var.private_subnets
}

data "aws_db_snapshot" "this" {
  db_snapshot_identifier = var.snapshot_arn
}

resource "aws_db_parameter_group" "this" {
  name   = "this-db-param-group"
  family = "mysql8.0"
}

resource "aws_db_instance" "this_rds" {
  identifier              = "this-db-instance"
  engine                  = "mysql"
  engine_version          = "8.0.32"
  instance_class          = "db.t3.small"
  allocated_storage       = 20
  storage_type            = "gp2"
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.db_sg_id]
  db_name                 = var.db_parameters["database"]
  username                = var.db_parameters["username"]
  password                = var.db_parameters["password"]
  backup_retention_period = 7
  skip_final_snapshot     = true
  snapshot_identifier     = data.aws_db_snapshot.this.id
  storage_encrypted       = true
  tags = {
    Name = "this-db-instance"
  }
}

resource "aws_ssm_parameter" "db_endpoint" {
  name      = "host"
  type      = "String"
  value     = aws_db_instance.this_rds.address
  overwrite = true
}

