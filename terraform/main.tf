provider "azurerm" {
  version = "~> 2.0.0"
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "Japan East"
}

resource "azurerm_eventhub_namespace" "example" {
  name                = "secondnw-dev01-je-2nd-deliverycompleted-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "example" {
  name                = "secondnw-deliverycompleted-consumer"
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.example.name
  partition_count     = 2
  message_retention   = 1
}
