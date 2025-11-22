# TechCorp Web Application Infrastructure

This Terraform project deploys a complete web application infrastructure on AWS with high availability, security, and scalability.

## Architecture Overview

- **VPC**: 10.0.0.0/16 with public and private subnets across two availability zones
- **Public Subnets**: For bastion host, NAT gateways, and Application Load Balancer
- **Private Subnets**: For web servers and database server
- **Security Groups**: Fine-grained access control for different components
- **Application Load Balancer**: Distributes traffic across web servers
- **Bastion Host**: Secure administrative access to private instances

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **Terraform** installed (version 1.0+)
3. **AWS CLI** configured with credentials
4. **EC2 Key Pair** created in AWS console
5. **public IP address** for bastion access

## Deployment Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd terraform-assessment
```
