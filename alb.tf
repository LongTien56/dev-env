module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "test-hblab"

  load_balancer_type = "application"
  create_security_group = false
  vpc_id             = var.vpc_id
  subnets            = [ for subnet_id in var.subnets : subnet_id ]
  security_groups    = [aws_security_group.alb_sg.id]
#   access_logs = {
#     bucket = "my-alb-logs"
#   }

  target_groups = [
    {
      name     = "hblab"
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

    # {
    #   name     = "hblab-https"
    #   backend_protocol = "HTTPS"
    #   backend_port     = 443
    #   target_type      = "instance"
    #   targets = {
    #     my_target = {
    #       target_id = module.ec2_instance.id
    #       port = 443
    #     }
    #   }
    # }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.alb_cert_arn
      #target_group_index = 0
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/html"
        status_code  = "404"
        message_body      = "<body><div class=\"mainbox\"><div class=\"msgr\">404</div><div class=\"msg\">このサイトにアクセスできません</div></div></body>"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      # target_group_index = 0
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
        host     = "#{host}"
        path     = "/#{path}"
        query    = "#{query}"
      }
    }
  ]

  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 1

      actions = [{
        type        = "forward"
        target_group_index = 0
      }]

      conditions = [
        {
          source_ip = ["113.32.157.178/32", "39.110.201.11/32"]
        },
        {
          path_patterns = ["/pmaitoen/*"]
        },
        {
          host_headers = ["hblab-test.itoen-shinhaiku.jp"]
        }
      ]
    },

    {
      https_listener_index = 0
      priority             = 2

      actions = [{
        type = "fixed-response"
        content_type = "text/plain"
        status_code  = "503"
        # message_body      = ""
      }]

      conditions = [{
        path_patterns = ["/pmaitoen/*"]
      }]
    },
    
    {
      https_listener_index = 0
      priority             = 3

      actions = [{
        type        = "forward"
        target_group_index = 0
      }]

      conditions = [{
          host_headers = ["hblab-test.itoen-shinhaiku.jp"]
      }]
    },

    {
      https_listener_index = 0
      priority             = 4

      actions = [{
        type        = "forward"
        target_group_index = 0
      }]

      conditions = [{
          host_headers = ["test.itoen-shinhaiku.jp"]
      }]
    }

  ]

  tags = {
    Environment = "dev"
  }
}


# resource "aws_lb_listener_rule" "default_rule" {
#   listener_arn = module.alb.http_tcp_listener_arns[0]
#       priority             = 1

#       actions {
#         type        = "forward"
#         target_group_index = 0
#       }

#       conditions 
#         {
#           source_ip = ["113.32.157.178/32", "39.110.201.11/32"]
#           path_patterns = ["/pmaitoen/*"]
#           http_request_method = ["GET", "POST"]
#           host_headers = ["itoen-shinhaiku.jp"]
#         }

# }




