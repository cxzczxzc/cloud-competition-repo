# Target group for the ALB
resource "aws_lb_target_group" "this_tg" {
  name_prefix = "tg-"
  port        = 5000
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path = "/"
  }
}

resource "aws_autoscaling_group" "this_asg" {
  name_prefix               = "this-asg-"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  launch_template {
    id      = var.aws_launch_template
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.this_tg.arn]
  # This needs to be fixed
  vpc_zone_identifier = var.private_subnets[*]
}

# Autoscaling policy targeting 50% utilization
resource "aws_autoscaling_policy" "this_scaling_policy" {
  name                   = "example-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "this_lb" {
  name               = "this-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets
}

# Listener for the ALB
resource "aws_lb_listener" "this_listener" {
  load_balancer_arn = aws_lb.this_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.this_tg.arn
    type             = "forward"
  }
}





