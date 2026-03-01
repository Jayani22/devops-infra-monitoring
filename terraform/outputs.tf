output "bastion_public_ip" {
    value = module.bastion.public_ip
}

output "private_instance_id" {
    value = module.ec2.instance_id
}