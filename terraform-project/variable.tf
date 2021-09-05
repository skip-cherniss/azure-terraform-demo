# ----------------------------------------------------------------------------------------------------------------
# Author: Skip M. Cherniss
# High Speed Low Drag
# Repository: https://github.com/skip-cherniss/azure-terraform-demo.git
# Youtube: https://www.youtube.com/channel/UCHPB5VZjZkDmHRy3QaYxbSA (High Speed Low Drag)
# Twitter:    https://twitter.com/HIGHSPEED0DRAG
# LinkedIn:   https://www.linkedin.com/in/skipcherniss/
# ----------------------------------------------------------------------------------------------------------------

variable tags {
        owner   = "highspeedlowdrag"
        env     = "demo"
        creator = "terraform"
    }

variable "storage_account_name" {
    description = "Defines the name for the storage account we are creating."
    default = "sthsldterraformdemo"
}

variable "location" {
    description = "Azure location"
    default = "centralus"
}

variable "storage_account_tier" {
    description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. Premium will not facilitate tables or queues"
    default = "Standard"
}

variable "storage_access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "storage_account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  default     = "ZRS"
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  type        = number
  default     = 31
}
