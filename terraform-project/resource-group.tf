# ----------------------------------------------------------------------------------------------------------------
# Author: Skip M. Cherniss
# High Speed Low Drag
# Repository: https://github.com/skip-cherniss/azure-terraform-demo.git
# Youtube: https://www.youtube.com/channel/UCHPB5VZjZkDmHRy3QaYxbSA (High Speed Low Drag)
# Twitter:    https://twitter.com/HIGHSPEED0DRAG
# LinkedIn:   https://www.linkedin.com/in/skipcherniss/
# ----------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------
# Azure Resource Group.
# ----------------------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "rg_vstudio_terraform_demo" {
  name = "rg-vstudio_terraform_demo"
  location = var.location
}