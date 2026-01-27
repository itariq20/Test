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
  tags = {
    yor_name             = "test_rg"
    yor_trace            = "5c0da4c2-9c1e-425e-aefe-323458e8a272"
    git_commit           = "0ed75db0438ab1ba13f2a387f3ebe45b0660c922"
    git_file             = "blabla.tf"
    git_last_modified_at = "2026-01-27 22:18:22"
    git_last_modified_by = "31933916+itariq20@users.noreply.github.com"
    git_modifiers        = "31933916+itariq20"
    git_org              = "itariq20"
    git_repo             = "Test"
  }
}

# Output to confirm deployment
output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}
