resource "random_pet" "preview" {
}

locals {
    environments = {
        "dev" = {
            name = "development"
            database = {
                edition = "Basic"
                max_size_gb = 2
            }
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            domain  = "dev.werk8.app"
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
        "stg" = {
            name = "staging"
            database = {
                edition = "Basic"
                max_size_gb = 2
            }
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            domain  = "staging.werk8.app"
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
        "ephemeral" = {
            name = random_pet.preview.id
            database = {
                edition = "Basic"
                max_size_gb = 2
            }
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            domain = "${lower(local.application_name)}-${random_pet.preview.id}-app.azurewebsites.net"
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
    }
}
