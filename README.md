# Rearc Quest Application Deployment

This project deploys the Rearc Quest application on AWS using containerization and Infrastructure as Code (IaC) principles.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Infrastructure as Code (IaC)](#infrastructure-as-code-iac)
4. [Docker Configuration](#docker-configuration)
5. [Deployment Instructions](#deployment-instructions)
6. [Testing the Deployment](#testing-the-deployment)
7. [Clean Up](#clean-up)
8. [Improvements and Future Work](#improvements-and-future-work)

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform (v1.0.0 or later)
- Docker
- Git

## Project Structure
rearc-quest-assignment/
├── .git/
├── .gitignore
├── README.md
├── app/
│   ├── Dockerfile
│   ├── package.json
│   ├── src/
│   │   └── 000.js
│   └── bin/
│       ├── 001
│       ├── 002
│       ├── 003
│       ├── 004
│       ├── 005
│       └── 006
└── terraform/
├── main.tf
├── variables.tf
├── outputs.tf
└── providers.tf

## Infrastructure as Code (IaC)

This project uses Terraform to manage the AWS infrastructure. The main components include:

- VPC and networking resources
- ECS Cluster and Fargate Service
- Application Load Balancer (ALB)
- ECR Repository
- CloudWatch Log Group
- Security Groups
- ACM Certificate (self-signed for demo purposes)

The Terraform files are located in the `terraform/` directory.

## Terraform State Management

This project uses an S3 backend to store the Terraform state file. This allows for better collaboration and state management. Before you can use this backend, you need to create the necessary AWS resources.

### Setting up the S3 Backend
Created AWS S3 bucket "quest-app-terraform-state" manually using the AWS Management Console

2. Enable versioning on the S3 bucket: Using the AWS Management console
3. Create a DynamoDB table for state locking: Using the AWS Management console


## Docker Configuration

The Dockerfile is located in the `app/` directory and is used to build the container image for the Rearc Quest application.

## Deployment Instructions

1. Clone the repository:
git clone https://github.com/andrew2sky/rearc-quest-assignment.git
cd rearc-quest-assignment

2. Build and push the Docker image:
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 821106082324.dkr.ecr.eu-west-1.amazonaws.com
docker build -t rearc-quest-app .
docker tag rearc-quest-app:latest 821106082324.dkr.ecr.eu-west-1.amazonaws.com/app-repo:latest
docker push 821106082324.dkr.ecr.eu-west-1.amazonaws.com/app-repo:latest

3. Deploy the infrastructure:
cd terraform
terraform init
terraform plan
terraform apply

When prompted, enter the value for the `secret_word` variable.

4. After the deployment is complete, Terraform will output the ALB DNS name. Make note of this for testing.

## Testing the Deployment

Use the ALB DNS name provided in the Terraform output to test the following endpoints:

- Index page: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/`
- AWS check: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/aws`
- Docker check: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/docker`
- Load Balancer check: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/loadbalanced`
- TLS check: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/tls`
- Secret Word check: `https://app-lb-1976250812.eu-west-1.elb.amazonaws.com/secret_word`
*Replace above DNS URL with your application loadbalancer DNS Name

## Clean Up

To avoid incurring unnecessary costs, remember to destroy the resources when you're done:
terraform destroy

## Improvements and Future Work

Given more time, the following improvements could be made to enhance the solution:

1. Implement proper networking with private subnets and a NAT gateway for enhanced security.
2. Set up auto-scaling for the ECS service based on CPU/memory utilization.
3. Implement a CI/CD pipeline for automated builds and deployments.
4. Use AWS Systems Manager Parameter Store or Secrets Manager for securely storing and retrieving the SECRET_WORD.
5. Implement proper logging and monitoring using CloudWatch Logs Insights and CloudWatch Alarms.
6. Set up a custom domain name and use a valid SSL certificate instead of a self-signed one.
7. Implement AWS WAF and Shield for additional security measures.
8. Use Terraform workspaces or create multiple environments (dev, staging, prod) for better separation of concerns.
9. Implement better error handling in the application code.
10. Use a reverse proxy like Nginx to handle static files and improve performance.
11. Implement rate limiting to protect against DoS attacks.
12. Use AWS X-Ray for distributed tracing to better understand and debug the application.
13. Implement proper health checks for the ECS tasks.
14. Set up automated testing for both the infrastructure and the application.

These improvements would make the solution more robust, secure, and production-ready.
