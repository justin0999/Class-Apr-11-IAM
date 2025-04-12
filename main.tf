provider "aws" {
  region = "us-east-1" # You can make this a variable if needed
}

# Create IAM groups
resource "aws_iam_group" "groups" {
  for_each = var.iam_groups
  name     = each.key
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "group_policies" {
  for_each   = var.iam_groups
  group      = aws_iam_group.groups[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

# Local map to associate users with their groups
locals {
  users_with_groups_main = flatten([
    for group, users in var.iam_users : [
      for user in users : {
        key   = "${group}-${user}"
        name  = user
        group = group
      }
    ]
  ])
  # Convert flattened list into a map
  users_with_groups_map = {
    for pair in local.users_with_groups_main : pair.key => {
      name  = pair.name
      group = pair.group
    }
  }
}

# Create IAM users
resource "aws_iam_user" "users" {
  for_each = local.users_with_groups_map

  name = each.value.name
  path = "/"
}

# Assign users to groups
resource "aws_iam_user_group_membership" "user_memberships" {
  for_each = local.users_with_groups_map

  user   = aws_iam_user.users[each.key].name
  groups = [aws_iam_group.groups[each.value.group].name]
}

# Set password policy
resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length         = 12
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                 = true
  require_symbols                 = true
  allow_users_to_change_password = true
}
