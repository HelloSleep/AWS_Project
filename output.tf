output "seoul_public_subnet_a" {
  value = aws_subnet.global-public-subnet-a.id
}
output "seoul_public_subnet_c" {
  value = aws_subnet.global-public-subnet-c.id
}
output "seoul_private_subnet_a" {
  value = aws_subnet.global-private-subnet-a-web.id
}
output "seoul_private_subnet_c" {
  value = aws_subnet.global-private-subnet-c-web.id
}
