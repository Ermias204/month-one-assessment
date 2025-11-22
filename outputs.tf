output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.techcorp_vpc.id
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "web_server_1_private_ip" {
  description = "Private IP of web server 1"
  value       = aws_instance.web_server_1.private_ip
}

output "web_server_2_private_ip" {
  description = "Private IP of web server 2"
  value       = aws_instance.web_server_2.private_ip
}

output "db_server_private_ip" {
  description = "Private IP of database server"
  value       = aws_instance.db_server.private_ip
}