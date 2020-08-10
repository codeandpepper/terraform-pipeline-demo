resource "azurerm_application_insights" "insights" {
    name                = "${lower(local.application_name)}-${lower(local.config.name)}-insights"
    location            = azurerm_resource_group.app_group.location
    resource_group_name = azurerm_resource_group.app_group.name
    application_type    = "web"
    tags                = local.tags
}