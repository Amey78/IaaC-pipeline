# Get ECR repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
# Return ECS cluster name
output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

# Return ECS service name
output "service_name" {
  value = aws_ecs_service.app.name
}
