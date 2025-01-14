resource "azurerm_resource_group" "rg-presetup-vm-test" {
  name     = var.rg_Name
  location = var.location
}

resource "azurerm_storage_account" "sa-vm-test" {
  depends_on               = [azurerm_resource_group.rg-presetup-vm-test]
  name                     = var.sa_Name
  resource_group_name      = var.rg_Name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "cnt-vm-test" {
  depends_on            = [azurerm_storage_account.sa-vm-test]
  name                  = var.cnt_Name
  storage_account_name  = azurerm_storage_account.sa-vm-test.name
  container_access_type = "private"
}

# Might not need as only storing .tfstate file

/*
data "azurerm_storage_account_blob_container_sas" "example" {
  connection_string = azurerm_storage_account.sa-vm-test1.primary_connection_string
  container_name    = azurerm_storage_container.cnt-vm-test1.name
  https_only        = true

  start  = "2025-01-01"
  expiry = "2025-03-01"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true 
    delete = true
    list   = true
  }
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_blob_container_sas.example.sas
}*/