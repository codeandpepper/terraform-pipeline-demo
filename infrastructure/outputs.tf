output "app" {
    value = {
        "hostname" = azurerm_app_service.app.default_site_hostname
        "image_tag" = var.tag
    }
}