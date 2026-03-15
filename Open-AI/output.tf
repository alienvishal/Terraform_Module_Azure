output "openai_endpoint" {
  description = "The endpoint of the Azure OpenAI resource"
  value       = azurerm_cognitive_account.openai.endpoint
}