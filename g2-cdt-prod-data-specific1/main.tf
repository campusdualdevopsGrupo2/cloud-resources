data "external" "get_dns" {
  # En caso de usar Python, usa este comando:
   program = ["python3", "get_dns.py", "chat-app-service"]
}

output "dns_value" {
  value = data.external.get_dns.result["dns"]
}