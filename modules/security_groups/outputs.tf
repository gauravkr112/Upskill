output "bastion_sg_id" {
  value = aws_security_group.Upskill_bastion_sg_block_public.id
}

output "private_instance_sg_id" {
  value = aws_security_group.private_instance_sg.id
}
