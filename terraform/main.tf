# Create AWS network
module "networking" {
  source = "./modules/networking"
}

# Create security groups and IAM roles
module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}

# Create ECR, ECS and Load Balancer
module "compute" {
  source = "./modules/compute"

  execution_role_arn    = module.security.ecs_execution_role_arn
  vpc_id                = module.networking.vpc_id
  public_subnet_1       = module.networking.public_subnet_1
  public_subnet_2       = module.networking.public_subnet_2
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
}

# Configure ECS autoscaling
module "monitoring" {
  source = "./modules/monitoring"

  cluster_name = module.compute.cluster_name
  service_name = module.compute.service_name
}
