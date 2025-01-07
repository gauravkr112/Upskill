output "vpc_id" {
  value = aws_vpc.Upskill_VPC.id
}

output "public_subnet_id" {
  value = aws_subnet.Upskill_PubSubnet.id
}

output "private_subnet_id" {
  value = aws_subnet.Upskill_PrivSubnet.id
}
