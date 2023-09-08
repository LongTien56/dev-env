module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
#  monitoring             = true
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = module.vpc.public_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  filename        = "${path.module}/mykey.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}


resource "aws_key_pair" "key_pair" {
  key_name   = "mykey-key"
  public_key = tls_private_key.key.public_key_openssh
}




resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = module.ec2_instance.availability_zone
    size = var.ebs_volume_size
    type = var.ebs_volume_type
    tags = {
        Name = "Ec2 extra volume"
    }
}

resource "aws_volume_attachment" "ebs_volume_attacthment"{
    device_name = "/dev/xvdh"
    volume_id = aws_ebs_volume.ebs-volume-1.id
    instance_id = module.ec2_instance.id
}