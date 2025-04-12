iam_users = {
  system_admin    = ["custom_sysadmin1", "custom_sysadmin2", "custom_sysadmin3"]
  database_admin  = ["custom_dbadmin1", "custom_dbadmin2", "custom_dbadmin3"]
  read_only       = ["custom_readonly1", "custom_readonly2", "custom_readonly3"]
}

iam_groups = {
  system_admin    = "AdministratorAccess"
  database_admin  = "AmazonRDSFullAccess"
  read_only       = "AmazonConnectReadOnlyAccess"
}

