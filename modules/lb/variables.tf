variable "name_prefix" {
  type    = string
  default = "my"
}

variable "subnets" {
  type    = list(string)
  default = []
}

variable "vpc" {
  type = string
}

variable "lb_listener_ports" {
  type    = list(number)
  default =  [80, 443] 
}