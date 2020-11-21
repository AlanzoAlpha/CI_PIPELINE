output "ec2_ip" {
  value = aws_instance.ec2.public_ip
}

output "users_ep" {
  value = aws_db_instance.users.id
}

output "tesdb_ep" {
  value = aws_db_instance.testdb.id
}

