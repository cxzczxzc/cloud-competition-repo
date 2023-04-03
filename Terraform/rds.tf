resource "aws_db_subnet_group" "example" {
  name       = "example-subnet-group"
  subnet_ids = aws_subnet.public_subnets.*.id
}

data "aws_db_snapshot" "example" {
  db_snapshot_identifier = var.snapshot_arn
}

resource "aws_security_group" "db_sg" {
  name_prefix = "example-db-sg-"
  vpc_id      = aws_vpc.example_vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update with your desired CIDR block
  }
}

resource "aws_db_parameter_group" "example" {
  name   = "example-db-param-group"
  family = "mysql8.0"
}

resource "aws_db_instance" "example" {
  identifier              = "example-db-instance"
  engine                  = "mysql"
  engine_version          = "8.0.32"
  instance_class          = "db.t3.small"
  allocated_storage       = 20
  storage_type            = "gp2"
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.example.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  name                    = local.parameters["database"]
  username                = local.parameters["username"]
  password                = local.parameters["password"]
  backup_retention_period = 7
  skip_final_snapshot     = true
  snapshot_identifier     = data.aws_db_snapshot.example.id
  tags = {
    Name = "example-db-instance"
  }
}

resource "aws_ssm_parameter" "db_endpoint" {
  name      = "host"
  type      = "String"
  value     = aws_db_instance.example.address
  overwrite = true
}
