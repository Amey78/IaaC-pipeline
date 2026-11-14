# Receive ECS execution role ARN from security module
variable "execution_role_arn" {
  type = string
}

# Receive VPC ID
variable "vpc_id" {
  type = string
}

# Receive public subnet IDs
variable "public_subnet_1" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

# Receive ALB security group ID
variable "alb_security_group_id" {
  type = string
}

# Receive ECS security group ID
variable "ecs_security_group_id" {
  type = string
}
