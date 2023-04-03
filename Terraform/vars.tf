variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the EC2 instances and ALB will be created"
  default     = "vpc-01bf09c59003a851b"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of IDs of subnets where the EC2 instances and ALB will be created"
  default     = ["subnet-0a80b8eedf06913b5", "subnet-05336f2e8848b41b9"]
}

variable "app_ami_id" {
  type        = string
  description = "Public AMI ID that includes application snapshot"
  default     = "ami-0e8a20c6da2c1ffbe"
}

variable "snapshot_arn" {
  type        = string
  description = "ARN of publicly accessible DB snapshot with application schema"
  default     = "arn:aws:rds:us-east-1:156463586173:snapshot:skillsdb-snapshot"
}


variable "param_overwrite" {
  type        = bool
  description = "Overwrite DB paramters: true/false"
  default     = true
}

