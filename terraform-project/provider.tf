# ----------------------------------------------------------------------------------------------------------------
# Author: Skip M. Cherniss
# High Speed Low Drag
# Repository: https://github.com/skip-cherniss/azure-terraform-demo.git
# Youtube: https://www.youtube.com/channel/UCHPB5VZjZkDmHRy3QaYxbSA (High Speed Low Drag)
# Twitter:    https://twitter.com/HIGHSPEED0DRAG
# LinkedIn:   https://www.linkedin.com/in/skipcherniss/
# ----------------------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------------------
# Required providers.
# ----------------------------------------------------------------------------------------------------------------
# be sure to provide a terraform.tfvars file with your 
# client_id
# client_secret
# tenant_id
# subscription_id

terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 2.55.0"
        }
        azuread = {
          source = "hashicorp/azuread"
          version = "~> 1.4.0"
        }
    }    
    required_version = ">= 0.13"
}

provider "azurerm" {
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
    subscription_id = var.subscription_id
    features {}
}

provider "azuread" {
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}
