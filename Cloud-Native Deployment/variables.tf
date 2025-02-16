variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "20.2.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["20.2.1.0/24", "20.2.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["20.2.3.0/24", "20.2.4.0/24"]
}

variable "cluster_name" {
  default = "atc-demo-eks-cluster"
}

variable "node_instance_type" {
  default = "m5.large"
}

variable "desired_capacity" {
  default = 1
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}


