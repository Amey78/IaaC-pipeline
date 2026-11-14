# Terraform and AWS provider requirements
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
# Security group for application load balancer
resource "aws_security_group" "alb" {
  name        = "iaac-alb-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "iaac-alb-sg"
  }
}
# Security group for ECS containers
resource "aws_security_group" "ecs" {
  name        = "iaac-ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic only from ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # Allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "iaac-ecs-sg"
  }
}
