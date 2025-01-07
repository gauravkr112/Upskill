output "role_name" {
  value = aws_iam_role.Upskill_VPC_SSM_InstanceRole.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.Upskill_VPC_SSM_InstanceProfile.name
}
