
variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "security_group_id" {
  description = "sg id"
  type        = string
}

variable "subnets_id" {
  description = "subnets id"
  type        = list(string)
}

variable "ec2_instance_id"{
  description = "sg id"
  type        = string
}


variable "alb_cert_arn"{
  description = "alb cert arn"
  type        = string
}
