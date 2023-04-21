variable "vpc_id" {
  type = string
}

variable "app_ami_id" {
  type = string
}

variable "ec2_sg_id" {
  type        = string
  description = " EC2 SG"
}
