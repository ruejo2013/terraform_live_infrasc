## Out var for prod infras deployment

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The dns name for each stages endpoint" 
}

output "asg_name" {
  value       = module.webserver_cluster.asg_name
  description = "The name of the Auto Scaling Group" 
}