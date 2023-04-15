variable "snapshot_arn" {
  type        = string
  description = "ARN of MySQL DB with the schema intalled"
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type        = list(string)
  description = "The list of subnets to host DB instance"
}

variable "db_parameters" {
  type        = map(string)
  description = "Map of DB configuration parameters for MySQL DB"
}

variable "db_sg_id" {
  type        = string
  description = "Securoty group for the DB"
  default     = ""
}
