variable "aws_region" {
  type = string
}

variable "instance_name" {
  type    = string
  default = "phase2-demo"
}

variable "key_name" {
  type = string
}

variable "eip_allocation_id" {
  type = string
}
