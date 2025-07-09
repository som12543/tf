output "instance_details" {
  value = aws_instance.server-1.ami

}

output "key" {
  value = aws_key_pair.key-t-1.public_key

}

output "sg_group" {
    value = aws_security_group.security-t-1.id
  
}