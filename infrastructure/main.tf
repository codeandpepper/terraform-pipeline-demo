locals {
    environment = terraform.workspace
    config = lookup(local.environments, local.environment,local.environments.ephemeral)
    tags = {
        Application = local.application_name
        Environment = local.config.name
    }
}

terraform {
    backend "azurerm" {
        resource_group_name   = "TerraformDemo"
        storage_account_name  = "tfdemobucket"
        container_name        = "terraform"
        key                   = "terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "app_group" {
    name = "${local.application_name}-${local.config.name}"
    location = local.location
    tags = local.tags
}
