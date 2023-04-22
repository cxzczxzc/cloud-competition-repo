
module "vpc" {
  source = "./vpc"

  vpc_cidr = "10.0.0.0/16"
  private_subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  public_subnet_cidr_blocks = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
}

module "sg" {
  source = "./sg"

  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "./rds"

  snapshot_arn    = "arn:aws:rds:us-east-1:156463586173:snapshot:skillsdb-snapshot"
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  db_parameters   = module.parameters.db_parameters
  db_sg_id        = module.sg.sg_ids["db_sg_id"]
}

module "ec2" {
  source = "./ec2"

  vpc_id     = module.vpc.vpc_id
  app_ami_id = "ami-0e8a20c6da2c1ffbe"
  ec2_sg_id  = module.sg.sg_ids["ec2_sg_id"]
}

module "parameters" {
  source = "./parameters"

  parameters = {
    username = "user"
    password = ""
    database = "skillsontario"
    port     = "3306"
  }
}

module "alb" {
  source              = "./alb"
  vpc_id              = module.vpc.vpc_id
  aws_launch_template = module.ec2.aws_launch_template.id
  public_subnets      = module.vpc.public_subnets
  private_subnets     = module.vpc.private_subnets
  alb_sg_id           = module.sg.sg_ids["alb_sg_id"]

  depends_on = [
    module.rds
  ]
}
