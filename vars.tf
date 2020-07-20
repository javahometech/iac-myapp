variable "vpc_cidr" {
  description = "Choose vpc cidr block"
  type        = string
  default     = "172.21.0.0/16"
}
variable "subnet_cidrs" {
  type    = list(string)
  default = ["172.21.0.0/24", "172.21.1.0/24", "172.21.2.0/24"]
}

# In real time one subnet per availability_zone
