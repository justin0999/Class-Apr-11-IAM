variable "iam_groups" {
  type = map(string)
  default = {
    system_admin   = "AdministratorAccess"
    database_admin = "AmazonRDSFullAccess"
    read_only      = "AmazonConnectReadOnlyAccess"
  }
}

variable "iam_users" {
  type = map(list(string))
  default = {
    system_admin   = ["sysadmin1", "sysadmin2", "sysadmin3"]
    database_admin = ["dbadmin1", "dbadmin2", "dbadmin3"]
    read_only      = ["readonly1", "readonly2", "readonly3"]
  }
}
