locals {
    common_container_settings = {
        "DOCKER_REGISTRY_SERVER_USERNAME"         = var.docker_username
        "DOCKER_REGISTRY_SERVER_URL"              = var.docker_url
        "DOCKER_REGISTRY_SERVER_PASSWORD"         = var.docker_password
        "WEBSITES_ENABLE_APP_SERVICE_STORAGE"     = false
        "WEBSITES_PORT"                           = 80
    }
    app_settings = {
        "APPINSIGHTS_KEY"                         = azurerm_application_insights.insights.instrumentation_key
    }
    container_settings = {        
        "APPSETTINGS"                             = jsonencode(merge(local.app_settings, local.config.app_settings))
        "PORT"                                    = 80
    }
    tag = var.tag
}

resource "azurerm_app_service_plan" "service_plan" {
    name                = "${lower(local.application_name)}-${lower(local.config.name)}-app-service-plan"
    location            = azurerm_resource_group.app_group.location
    resource_group_name = azurerm_resource_group.app_group.name
    kind                = "Linux"
    per_site_scaling    = true
    reserved            = true
    tags                = local.tags

    sku {
        tier = local.config.app_service.tier
        size = local.config.app_service.size
    }
}

resource "azurerm_app_service" "app" {
    name                    = "${lower(local.application_name)}-${lower(local.config.name)}-app"
    location                = azurerm_resource_group.app_group.location
    resource_group_name     = azurerm_resource_group.app_group.name
    app_service_plan_id     = azurerm_app_service_plan.service_plan.id
    https_only              = true
    client_affinity_enabled = false
    tags                    = local.tags
    app_settings            = merge(local.config.container_settings, local.common_container_settings, local.container_settings)
    site_config {
        always_on           = true
        linux_fx_version    = "DOCKER|${local.docker_image}:${local.tag}"
    }
}
