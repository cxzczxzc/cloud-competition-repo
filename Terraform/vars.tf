# Define the VPC CIDR block
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

# Define the private subnet CIDR blocks
variable "private_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define the public subnet CIDR blocks
variable "public_subnet_cidr_blocks" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Define the availability zones to use
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "app_ami_id" {
  type        = string
  description = "Public AMI ID that includes application snapshot"
  default     = "ami-0e8a20c6da2c1ffbe"
}

# Define ARN of the DB snapshot that has application snapshot
variable "snapshot_arn" {
  type        = string
  description = "ARN of publicly accessible DB snapshot with application schema"
  default     = "arn:aws:rds:us-east-1:156463586173:snapshot:skillsdb-snapshot"
}

# Define the parameter names and values as objects
variable "parameters" {
  type = map(string)
  default = {
    username = "user"
    password = ""
    database = "skillsontario"
    port     = "3306"
  }
}

