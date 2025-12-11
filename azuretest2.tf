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
}

# 3. Resource: Azure Resource Group (Example Azure Resource)
resource "azurerm_resource_group" "test_rg" {
  name     = "xyz-resource-group"
  location = "East US" # Replace with your desired Azure region (location)
}

# Output to confirm deployment
output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}
