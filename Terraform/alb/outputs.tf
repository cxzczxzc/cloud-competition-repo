output "alb_security_group" {
  value = aws_security_group.alb_sg
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.this_asg
}