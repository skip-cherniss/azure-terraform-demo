# ----------------------------------------------------------------------------------------------------------------
# Author: Skip M. Cherniss
# High Speed Low Drag
# Repository: https://github.com/skip-cherniss/azure-terraform-demo.git
# Youtube: https://www.youtube.com/channel/UCHPB5VZjZkDmHRy3QaYxbSA (High Speed Low Drag)
# Twitter:    https://twitter.com/HIGHSPEED0DRAG
# LinkedIn:   https://www.linkedin.com/in/skipcherniss/
# ----------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------
# Azure Storage Account.
# ----------------------------------------------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#network_rules
# Note, the link doesn't take you to the exact space on the page, just continue to search for network_rules
resource "azurerm_storage_account" "storage" {
  name                      = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg_vstudio_terraform_demo.name
  location                  = var.location
  account_kind              = "StorageV2"
  account_tier              = var.storage_account_tier
  account_replication_type  = var.storage_account_replication_type
  access_tier               = var.storage_access_tier
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention
    }    
  }
  network_rules {
    default_action = "Deny" 
    ip_rules = ["1.1.1.1/24"] 
    virtual_network_subnet_ids = ["${data.azurerm_subnet.demo_subnet.id}"] 
    bypass = ["Logging","Metrics"]

  }
  tags = local.tags
}

# ----------------------------------------------------------------------------------------------------------------
# Locals Storage Endpoints Array
# ----------------------------------------------------------------------------------------------------------------
# when hosting a storage account over a private network, you will require a private endpoint for each service
# table will get a private endpoint setup in the privatelink.table.core.windows.net private dns zone
# blob will get a private endpoint setup in the privatelink.blob.core.windows.net private dns zone

locals { 
  storage_endpoints = {
    "storage_blob" = {
      "name" = "pe-hsldterraformdemo-blob",
      "subresource" = "blob",
      "subnet_id" = data.azurerm_subnet.demo_subnet.id,
      "dns_zone_ids" = [data.azurerm_private_dns_zone.privatelink_azure_blob.id] 
    },
    "storage_table" = {
      "name" = "pe-hsldterraformdemo-table",
      "subresource" = "table",
      "subnet_id" = data.azurerm_subnet.demo_subnet.id, 
      "dns_zone_ids" = [data.azurerm_private_dns_zone.privatelink_azure_table.id] 
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------
# Private Endpoints
# ----------------------------------------------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint

resource "azurerm_private_endpoint" "private_endpoints" {
  for_each = local.storage_endpoints
  name = each.value["name"]
  resource_group_name = azurerm_resource_group.rg_vstudio_terraform_demo.name
  location = var.location
  subnet_id = each.value["subnet_id"]
  tags = local.tags
  private_service_connection {
    name = var.storage_account_name
    is_manual_connection = false
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names = [each.value["subresource"]]
  }
  private_dns_zone_group {
    name = "lnk-${each.value["name"]}"
    private_dns_zone_ids = each.value["dns_zone_ids"]
  }
}

# ----------------------------------------------------------------------------------------------------------------
# IAM
# ----------------------------------------------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group

resource "azurerm_role_assignment" "sthsldterraformdemo_blob_contributor_alpha_company" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_group.alpha_company.object_id
}

resource "azurerm_role_assignment" "sthsldterraformdemo_file_contributor_alpha_company" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = data.azuread_group.alpha_company.object_id
}

resource "azurerm_role_assignment" "sthsldterraformdemo_queue_contributor_alpha_company" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azuread_group.alpha_company.object_id
}

resource "azurerm_role_assignment" "sthsldterraformdemo_table_contributor_alpha_company" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = data.azuread_group.alpha_company.object_id
}

resource "azurerm_role_assignment" "sthsldterraformdemo_account_contributor_alpha_company" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = data.azuread_group.alpha_company.object_id
}

