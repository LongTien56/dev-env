module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "aurora-mysql"
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class = var.rds_instance_class
  instances = {
    one = {}
    two = {
      instance_class = var.rds_instance_class
    }
  }
  master_username = var.rds_user_name
  manage_master_user_password = true
  vpc_id               = module.vpc.vpc_id
  create_db_subnet_group = true
  subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10
  skip_final_snapshot = true
#   enabled_cloudwatch_logs_exports = ["mysql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}