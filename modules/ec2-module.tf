module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  ami = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
#  monitoring             = true
#   associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = module.vpc.public_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}