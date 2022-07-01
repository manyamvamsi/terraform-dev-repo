terraform {
  backend "azurerm"{
    resource_group_name = "storage-tfstate-rg"
    storage_account_name = "tfstateeastus110"
    container_name = "terraformdev"
    key = "terraform.terraformdev"
    access_key = "cGBJx6dYHMNeTa8QDsZ47qmFby+TXRcP7jxZYdbWW57wc/mz/TNr57s0T7tTrEZmIED43uqd59XA+ASt81lCgA=="
  }
}
provider "azurerm" {
    features {

    }  
    subscription_id = var.subscription_id
    client_id = var.client_id
    tenant_id = var.tenant_id
    client_secret = var.client_secret

} 
locals {
  setup_name = "practice-hyd"
}
resource "azurerm_resource_group" "webapprg1" {
    name = "webapprg"
    location = "East US"
    tags = {
      "name" = "${local.setup_name}-rsg"
    }
  
}
resource "azurerm_app_service_plan" "appplan11" {
    name = "appplandev"
    location = azurerm_resource_group.webapprg1.location
    resource_group_name = azurerm_resource_group.webapprg1.name
    sku {
      tier = "standard"
      size = "S1"
    }
    tags = {
      "name" = "${local.setup_name}-appplan"
    } 
    depends_on = [
      azurerm_resource_group.webapprg1
    ]
}
resource "azurerm_app_service" "webapp1" {
    name = "webappdev644"
    location = azurerm_resource_group.webapprg1.location
    resource_group_name = azurerm_resource_group.webapprg1.name
    app_service_plan_id = azurerm_app_service_plan.appplan11.id
    tags = {
      "name" = "${local.setup_name}-webapp"
    }
    depends_on = [
      azurerm_app_service_plan.appplan11
    ]
  
}
