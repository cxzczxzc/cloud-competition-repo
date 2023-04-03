output "vpc_id" {
  value = aws_vpc.this_vpc.id
}

output "private_subnets" {
  value = aws_subnet.private_subnets
}

output "private_subnets" {
  value = aws_subnet.private_subnets
}

output "public_subnets" {
  value = aws_subnet.public_subnets
}

output "internet_gateway" {
  value = aws_internet_gateway.this_igw
}

output "private_route_table" {
  value = aws_route_table.private_route_table
}

output "public_route_table" {
  value = aws_route_table.public_route_table
}
