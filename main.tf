module "ec2_module" {
  source = "./module/ec2-module" # Đường dẫn tương đối đến thư mục module
  ec2_ami_id = var.ami
  instance_type = var.instance_type
  ec2_sg_group = aws_security_group.ec2_sg.id
  subnet = var.subnets[0]
  ec2_volume_size = var.ebs_volume_size
  ec2_volume_type = var.ebs_volume_type
}


module "alb_module" {
    source = "./module/alb-module"
    vpc_id = var.vpc_id
    security_group_id = aws_security_group.alb_sg.id
    subnets_id = var.subnets
    ec2_instance_id = module.ec2_module.ec2_instance_id
    alb_cert_arn = var.alb_cert_arn
}

module "route53" {
    source = "./module/route53-module"
    alb_dns_name = module.alb_module.lb_dns_name
}