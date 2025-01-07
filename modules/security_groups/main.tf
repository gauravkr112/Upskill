resource "aws_security_group" "Upskill_bastion_sg_block_public" {
  name        = var.bastion_sg_name
  description = "Restrict access to bastion host from specific IPs"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.16.0.0/16"] # Restrict to internal CIDR only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow egress to the world (important for SSM)
  }

  tags = {
    Name = var.bastion_sg_name
  }
}

resource "aws_security_group" "private_instance_sg" {
  name        = var.private_sg_name
  description = "Allow access from resources in the public subnet only"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.16.1.0/24"] # Allow SSH from public subnet only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic out, including to SSM endpoints
  }

  tags = {
    Name = var.private_sg_name
  }
}
