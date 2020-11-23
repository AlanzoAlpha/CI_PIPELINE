output "ec2_ip" {
  value = aws_instance.ec2.public_ip
}

output "users_ep" {
  value = aws_db_instance.users.id
}

output "tesdb_ep" {
  value = aws_db_instance.testdb.id
}


output "eks_cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

output "eks_cluster_certificat_authority" {
  value = aws_eks_cluster.aws_eks.certificate_authority
}
