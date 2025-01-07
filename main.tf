module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.16.0.0/16"
  vpc_name = "Upskill-VPC"
  public_subnet_cidr = "10.16.1.0/24"
  private_subnet_cidr = "10.16.2.0/24"
  public_subnet_az = "eu-west-1a"
  private_subnet_az = "eu-west-1b"
  public_subnet_name = "Upskill-PubSubnet"
  private_subnet_name = "Upskill-PrivSubnet"
  igw_name = "Upskill-VPC-IGW"
  nat_gateway_name = "Upskill-VPC-NAT-Public"
  public_rtb_name = "Upskill-VPC-RTB-Public"
  private_rtb_name = "Upskill-VPC-RTB-Private"
}

module "iam" {
  source = "./modules/iam"
  role_name = "Upskill-VPC-SSM-InstanceRole"
  policy_attachment_name = "Upskill-VPC-SSM-PolicyAttachment"
  instance_profile_name = "Upskill-VPC-SSM-InstanceProfile"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  bastion_sg_name = "Upskill-Bastion-SG-Block-Public"
  private_sg_name = "Private-Instance-SG"
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = "ami-0e9085e60087ce171"
  instance_type = "t2.micro"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  bastion_sg_id = module.security_groups.bastion_sg_id
  private_sg_id = module.security_groups.private_instance_sg_id
  instance_profile_name = module.iam.instance_profile_name
  public_instance_name = "Public-Instance"
  private_instance_name = "Private-Instance"
}
