module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = "itoen-shinhaiku.jp"

  records = [
    {
      name    = "hblab-test"
      type    = "CNAME"
      ttl     = 300
      records = ["test-hblab-1543258129.ap-northeast-1.elb.amazonaws.com"]
      # records = [ module.alb.lb_dns_name ]
    }
  ]

#   depends_on = [module.zones]
}