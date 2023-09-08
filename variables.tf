
#vpc
variable "region" {
  default     = "ap-southeast-1"
  description = "aws region"
  type        = string
}

#ec2
variable "instance_type" {
  default     = "t3.small"
  description = "EC2 instance type"
  type        = string
}

variable "ami" {
  default     = "ami-0df7a207adb9748c7"
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
  default     = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  description = "Alb cert arn"
  type        = string
}


#rds
variable "rds_engine" {
  default     = "aurora-mysql"
  description = "RDS engine"
  type        = string
}

variable "rds_engine_version" {
  default     = "8.0.mysql_aurora.3.04.0"
  description = "RDS engine version"
  type        = string
}

variable "rds_instance_class" {
  default     = "db.t3.medium"
  description = "RDS instance class"
  type        = string
}


variable "rds_user_name" {
  default     = "admin"
  description = "RDS username"
  type        = string
}





# variable "vpc_id" {
#   default     = ""
#   description = "aws vpc id"
#   type        = string
# }