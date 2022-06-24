module "network"{
    source = "./modules/network"

    network_name = "tf-vnet"
    network_location = "westeurope"
    network_rg = "example-resources"

    depends_on = [azurerm_resource_group.example]
}

module "appservice"{
    source = "./modules/appservices"

    app_service_plan_name = "dev-app"
    app_service_plan_location = "westeurope"
    app_service_plan_rg = "example-resources"
    app_service_plan_tiers = "Standard"
    app_service_plan_sku = "S1"

    app_service_name = "devwebapp"
    app_service_location = "westeurope"
    app_service_rg = "example-resources"
    app_service_tag_env = "dev"

    depends_on = [azurerm_resource_group.example]
}

module "postgre"{
    source = "./modules/data"

    postgre_name = "postgre2021"
    postgre_location = "westeurope"
    postgre_rg = "example-resources"
    postgre_administrator_login = var.administrator_login
    postgre_administrator_login_password = var.administrator_login_password
    postgre_sku_name = "GP_Gen5_4"
    postgre_version = "9.6"
    postgre_storage_mb = "640000"

    depends_on = [azurerm_resource_group.example]
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

output "app_service_url" {
    value = module.appservice.app_service_url
}

output "postgre_sql_fqdn" {
    value = module.postgre.postgre_fqdn
}