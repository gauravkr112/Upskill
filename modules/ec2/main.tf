resource "aws_instance" "public_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  security_groups        = [var.bastion_sg_id]
  iam_instance_profile   = var.instance_profile_name
  tags = {
    Name = var.public_instance_name
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  security_groups        = [var.private_sg_id]
  iam_instance_profile   = var.instance_profile_name
  tags = {
    Name = var.private_instance_name
  }
}
