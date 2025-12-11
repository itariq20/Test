# main.tf for Azure Resource Group 'xyz'

# 1. Terraform Block (For Azure)
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.4.0"
    }
  }
}

# 2. Azure Provider Configuration with Subscription ID
provider "azurerm" {
  features {}
  # WARNING: Replace 'YOUR_AZURE_SUBSCRIPTION_ID' with your actual ID
  subscription_id = "YOUR_AZURE_SUBSCRIPTION_ID"
}

# 3. Resource: Azure Resource Group (Example Azure Resource)
resource "azurerm_resource_group" "test_rg" {
  name     = "xyz-resource-group"
  location = "East US" # Replace with your desired Azure region (location)
  tags = {
    yor_name  = "test_rg"
    yor_trace = "537d7908-90ed-425b-a343-31e140d1a9e0"
  }
}

# Output to confirm deployment
output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}
