# Violates Condition 2: Version constraint does NOT start with '4.'
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.99" # Fails: This is an older, v3 version
    }
  }
}

# Violates Condition 1: subscription_id is missing
provider "azurerm" {
  features {}
  # subscription_id = var.azure_subscription_id # This line is intentionally missing
}

# Add a simple Azure resource to make this a valid, runnable configuration
resource "azurerm_resource_group" "rg" {
  name     = "test-rg-checkov-fail"
  location = "East US"
  tags = {
    yor_name  = "rg"
    yor_trace = "d4795060-ff46-4d3b-893b-26394f9a5097"
  }
}
