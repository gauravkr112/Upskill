resource "aws_iam_role" "Upskill_VPC_SSM_InstanceRole" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
  tags = {
    Name = var.role_name
  }
}

resource "aws_iam_policy_attachment" "Upskill_VPC_SSM_PolicyAttachment" {
  name       = var.policy_attachment_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.Upskill_VPC_SSM_InstanceRole.name]
}

resource "aws_iam_instance_profile" "Upskill_VPC_SSM_InstanceProfile" {
  name = var.instance_profile_name
  role = aws_iam_role.Upskill_VPC_SSM_InstanceRole.name
}
