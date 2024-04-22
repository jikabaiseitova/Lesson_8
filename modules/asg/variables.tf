variable "name_prefix" {}
variable "instance_type" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "public_subnets" {
   type = list(string)
} 
variable "sg" {}