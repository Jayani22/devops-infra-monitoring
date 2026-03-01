module "vpc" {
    source              = "./modules/vpc"
    env                 = var.env
    vpc_cidr            = var.vpc_cidr
    public_subnet_cidr  = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    availability_zone   = var.availability_zone
}

module "bastion_sg" {
    source  = "./modules/sg"
    name    = "${var.env}-bastion-sg"
    vpc_id  = module.vpc.vpc_id

    ingress_rules = [
        {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.allowed_ip
        }
    ]
}

module "private_sg" {
    source = "./modules/sg"
    name   = "${var.env}-private-sg"
    vpc_id = module.vpc.vpc_id
    ingress_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      source_sg = module.bastion_sg.sg_id
    },
    {
      from_port = 9090
      to_port   = 9090
      protocol  = "tcp"
      source_sg = module.bastion_sg.sg_id
    },
    {
      from_port = 3000
      to_port   = 3000
      protocol  = "tcp"
      source_sg = module.bastion_sg.sg_id
    }
  ]
}

module "bastion" {
    source        = "./modules/ec2"
    env           = "${var.env}-bastion"
    ami_id        = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.public_subnet_id
    sg_id         = module.bastion_sg.sg_id
    key_name      = var.key_name
}

module "ec2" {
    source        = "./modules/ec2"
    env           = var.env
    ami_id        = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.private_subnet_id
    sg_id         = module.private_sg.sg_id
    key_name      = var.key_name
}