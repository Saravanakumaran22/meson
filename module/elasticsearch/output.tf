# output "elasticsearch_endpoint" {
#   description = "Endpoint of the Elasticsearch domain"
#   value       = aws_elasticsearch_domain.elasticsearch.endpoint
# }

# output "kibana_endpoint" {
#   description = "Kibana endpoint of the Elasticsearch domain"
#   value       = aws_elasticsearch_domain.elasticsearch.kibana_endpoint
# }

# output "es_username" {
#   description = "Master username for Elasticsearch"
#   value       = aws_elasticsearch_domain.elasticsearch.advanced_security_options[0].master_user_options[0].master_user_name
# }

# output "es_password" {
#   description = "Master password for Elasticsearch"
#   value       = aws_elasticsearch_domain.elasticsearch.advanced_security_options[0].master_user_options[0].master_user_password
# }

# output "elasticsearch_arn" {
#   description = "ARN of the Elasticsearch domain"
#   value       = aws_elasticsearch_domain.elasticsearch.arn
# }
