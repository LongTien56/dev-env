
#vpc
variable "region" {
  default     = "ap-northeast-1"
  description = "aws region"
  type        = string
}


variable "vpc_id" {
  default     = "vpc-055e455a5931b6e40"
  description = "aws vpc id"
  type        = string
}

variable "subnets" {
  type        = list(string)
  default     = ["subnet-0579f21ba3dcae70c", "subnet-0186a7f4d48d55823", "subnet-02d7298b72c287737"]
  description = "aws subnets"
}


#ec2
variable "instance_type" {
  default     = "t3.micro"
  description = "EC2 instance type"
  type        = string
}

variable "ami" {
  default     = "ami-07d6bd9a28134d3b3"
  description = "EC2 ami"
  type        = string
}

variable "ebs_volume_size" {
  default     = 20
  description = "EBS volume size"
  type        = number
}
variable "ebs_volume_type" {
  default     = "gp2"
  description = "EBS voume type"
  type        = string
}

#alb
variable "alb_cert_arn" {
  default     = "arn:aws:acm:ap-northeast-1:185886701365:certificate/2600d11c-fa95-45b7-9aa6-f35e9de56126"
  description = "Alb cert arn"
  type        = string
}


#rds
# variable "rds_engine" {
#   default     = "aurora-mysql"
#   description = "RDS engine"
#   type        = string
# }

# variable "rds_engine_version" {
#   default     = "8.0.mysql_aurora.3.04.0"
#   description = "RDS engine version"
#   type        = string
# }

# variable "rds_instance_class" {
#   default     = "db.t3.medium"
#   description = "RDS instance class"
#   type        = string
# }


# variable "rds_user_name" {
#   default     = "admin"
#   description = "RDS username"
#   type        = string
# }




