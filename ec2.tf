module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  count = 2
  name = "test-hblab"
  ami = var.ami
  instance_type          = var.instance_type
  key_name               = "test-hblab.pem"
#  monitoring             = true
#   associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.subnets[0]
  root_block_device= [{
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# resource "tls_private_key" "key" {
#   algorithm = "RSA"
# }

# resource "local_sensitive_file" "private_key" {
#   filename        = "${path.module}/test-hblab.pem"
#   content         = tls_private_key.key.private_key_pem
#   file_permission = "0400"
# }


# resource "aws_key_pair" "key_pair" {
#   key_name   = "test-hblab"
#   public_key = tls_private_key.key.public_key_openssh
# }


# resource "aws_ebs_volume" "ebs-volume-1" {
#     availability_zone = module.ec2_instance.availability_zone
#     size = var.ebs_volume_size
#     type = var.ebs_volume_type
#     tags = {
#         Name = "Ec2 extra volume"
#     }
# }

# resource "aws_volume_attachment" "ebs_volume_attacthment"{
#     device_name = "/dev/xvdh"
#     volume_id = aws_ebs_volume.ebs-volume-1.id
#     instance_id = module.ec2_instance.id
# }


resource "aws_eip" "eip" {
  instance = module.ec2_instance[0].id
  vpc      = true
  tags = {
        Name = "hblab-test"
  }
}

resource "aws_eip" "eip2" {
  instance = module.ec2_instance[1].id
  vpc      = true
  tags = {
        Name = "hblab-test"
  }
}


# resource "aws_eip_association" "eip-association" {
#   instance_id   = module.ec2_instance.id
#   allocation_id = aws_eip.eip.id
# }