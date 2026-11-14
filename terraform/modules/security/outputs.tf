# Return ALB security group ID
output "alb_security_group_id" {
  value = aws_security_group.alb.id
}
# Return ECS execution role ARN
output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}
# Return ECS security group ID
output "ecs_security_group_id" {
  value = aws_security_group.ecs.id
}
