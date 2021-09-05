# ----------------------------------------------------------------------------------------------------------------
# Author: Skip M. Cherniss
# High Speed Low Drag
# Repository: https://github.com/skip-cherniss/azure-terraform-demo.git
# Youtube: https://www.youtube.com/channel/UCHPB5VZjZkDmHRy3QaYxbSA (High Speed Low Drag)
# Twitter:    https://twitter.com/HIGHSPEED0DRAG
# LinkedIn:   https://www.linkedin.com/in/skipcherniss/
# ----------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------
# Data Sources.
# ----------------------------------------------------------------------------------------------------------------
# The expectation would be you already have a local vnet and subnet setup to add the storage account 
# Additionally, you would already have your Private DNS Zones created for
# privatelink.table.core.windows.net
# privatelink.blob.core.windows.net
#
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group
#

data "azurerm_subnet" "demo_subnet" {
  name = "sub-demo-storage"
  virtual_network_name = "vnet-highspeedlowdrag"
  resource_group_name = "rg-demo-network"
}

data "azurerm_private_dns_zone" "privatelink_azure_blob" {
  provider = azurerm
  name = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-demo-network"
}

data "azurerm_private_dns_zone" "privatelink_azure_table" {
  provider = azurerm
  name = "privatelink.table.core.windows.net"
  resource_group_name = "rg-demo-network"
}

data "azuread_group" "alpha_company" {
  display_name = "alpha_company"
}