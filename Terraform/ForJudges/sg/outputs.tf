output "sg_ids" {
  value = {
    alb_sg_id = aws_security_group.alb_sg.id,
    ec2_sg_id = aws_security_group.ec2_sg.id,
    db_sg_id  = aws_security_group.db_sg.id,
  }
}

