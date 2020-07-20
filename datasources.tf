data "aws_availability_zones" "available" {
  state = "available"
}

output "azs" {
    value = local.az_names
}