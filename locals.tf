locals {
  az_names       = data.aws_availability_zones.available.names
  az_length      = length(local.az_names)
  pub_sub_ids    = aws_subnet.public.*.id
  pub_sub_length = length(local.pub_sub_ids)
}