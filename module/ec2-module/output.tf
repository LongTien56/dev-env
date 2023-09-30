output "ec2_instance_id" {
  value = [for instance in module.ec2_instance : instance.id]
}
