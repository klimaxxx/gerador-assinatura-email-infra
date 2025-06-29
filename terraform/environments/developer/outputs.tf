output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
} 