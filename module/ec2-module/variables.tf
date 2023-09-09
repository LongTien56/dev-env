
variable "ec2_ami_id"{
  description = "ec2 ami id"
  type        = string
}

variable "instance_type"{
  description = "ec2 instance type"
  type        = string
}

variable "ec2_sg_group"{
  description = "ec2 sg group"
  type        = string
}


variable "subnet"{
  description = "ec2 subnet"
  type        = string
}

variable "ec2_volume_size"{
  description = "ec2 volume size"
  type        = number
}

variable "ec2_volume_type"{
  description = "ec2 volume type"
  type        = string
}

