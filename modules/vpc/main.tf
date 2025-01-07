resource "aws_vpc" "Upskill_VPC" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "Upskill_PubSubnet" {
  vpc_id            = aws_vpc.Upskill_VPC.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.public_subnet_az
  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "Upskill_PrivSubnet" {
  vpc_id            = aws_vpc.Upskill_VPC.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_internet_gateway" "Upskill_VPC_igw" {
  vpc_id = aws_vpc.Upskill_VPC.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "Upskill_VPC_nat_public" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.Upskill_PubSubnet.id
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table" "Upskill_VPC_rtb_public" {
  vpc_id = aws_vpc.Upskill_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Upskill_VPC_igw.id
  }
  tags = {
    Name = var.public_rtb_name
  }
}

resource "aws_route_table" "Upskill_VPC_rtb_private" {
  vpc_id = aws_vpc.Upskill_VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Upskill_VPC_nat_public.id
  }
  tags = {
    Name = var.private_rtb_name
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Upskill_PubSubnet.id
  route_table_id = aws_route_table.Upskill_VPC_rtb_public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.Upskill_PrivSubnet.id
  route_table_id = aws_route_table.Upskill_VPC_rtb_private.id
}
