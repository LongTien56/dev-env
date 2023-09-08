module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "test-hblab"

  load_balancer_type = "application"

  vpc_id             = var.vpc_id
  subnets            = [ for subnet_id in var.subnets : subnet_id ]
  security_groups    = [aws_security_group.alb_sg.id]
#   access_logs = {
#     bucket = "my-alb-logs"
#   }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.ec2_instance.id
          port = 80
        }
      }
    },

    {
      name_prefix      = "ssl-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.ec2_instance.id
          port = 443
        }
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.alb_cert_arn
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]



  tags = {
    Environment = "dev"
  }
}
