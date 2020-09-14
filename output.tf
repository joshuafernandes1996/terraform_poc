output "WebServer-Instance-IP" {
  value = aws_instance.main_poc.public_ip
}

output "Database-Instance-IP" {
  value = aws_instance.db.public_ip
}