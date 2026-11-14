# Create ECR repository to store Docker images
resource "aws_ecr_repository" "app" {
  name = "iaac-pipeline-app"

  # Scan Docker images for vulnerabilities
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "iaac-pipeline-ecr"
  }
}

# Create ECS cluster to manage containers
resource "aws_ecs_cluster" "main" {
  name = "iaac-pipeline-cluster"

  tags = {
    Name = "iaac-pipeline-cluster"
  }
}
