variable "vpc_id" {
  type = string
}

variable "aws_launch_template" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}
