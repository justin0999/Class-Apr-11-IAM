output "created_users" {
  value = [for user in aws_iam_user.users : user.name]
}

output "created_groups" {
  value = [for group in aws_iam_group.groups : group.name]
}
