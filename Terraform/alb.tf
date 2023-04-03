
# Security group for the ALB
resource "aws_security_group" "alb_sg" {
  name_prefix = "example-alb-sg-"

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

resource "aws_autoscaling_group" "example_asg" {
  name_prefix               = "example-asg-"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  launch_template {
    id      = aws_launch_template.example_lt.id
    version = "$Latest"
  }
  target_group_arns   = [aws_lb_target_group.example_tg.arn]
  vpc_zone_identifier = var.subnet_ids
  depends_on          = [aws_ssm_parameter.db_endpoint]
}

# Target group for the ALB
resource "aws_lb_target_group" "example_tg" {
  name_prefix = "tg-"
  port        = 5000
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path = "/"
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "example_lb" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids
}

# Listener for the ALB
resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.example_tg.arn
    type             = "forward"
  }
}





