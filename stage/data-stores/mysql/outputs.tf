
output "db_address" {
  value       = aws_db_instance.mysql_db.address 
  description = "connect to the database at this endpoint"
}


output "port" {
  value        = aws_db_instance.mysql_db.port
  description  = "The port the db is listening on"
}