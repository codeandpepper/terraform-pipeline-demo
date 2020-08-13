resource "random_pet" "preview" {
}

locals {
    environments = {
        "dev" = {
            name = "development"
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
        "stg" = {
            name = "staging"
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
        "ephemeral" = {
            name = random_pet.preview.id
            app_service = {
                tier = "Basic"
                size = "B2"
            }
            container_settings = {
                "NO_INDEX" = "1"
            }
            app_settings = {
            }
        }
    }
}
