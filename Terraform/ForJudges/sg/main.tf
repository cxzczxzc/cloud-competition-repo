# Security group for the ALB
resource "aws_security_group" "alb_sg" {
  name_prefix = "this-alb-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your desired CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for the EC2 instances
resource "aws_security_group" "ec2_sg" {
  name_prefix = "this-ec2-sg-"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Security Group
resource "aws_security_group" "db_sg" {
  name_prefix = "this-db-sg-"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ec2_sg.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
