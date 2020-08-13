# Prerequisites

1. Azure account with active subscription. Note the subscription id as `ARM_SUBSCRIPTION_ID`.

# Setup

## Azure service account
This account is required in order to manage Azure resources via Terraform.
1. Register new application in Azure (App registrations), note Application (client) ID as `ARM_CLIENT_ID` and Directory (tenant) ID as `ARM_TENANT_ID`.
2. Create new secret for that application and note it down as `ARM_CLIENT_SECRET`.
3. Assign newly created application sufficient permissions in subscription, ie. `Contributor` role.

## Storage account
This is required for Terraform remote state storage. 
1. Create new Storage Account in Azure named `terraform`, add it to `TerraformDemo` resource group.
2. Create new blob container called `terraform` in that new storage account.
3. Note the access key to storage account as `ARM_ACCESS_KEY`.

_NOTE: Above values here have to be hardcoded as they cannot be sourced from variables, if you wish to change them it will require modyfication to `main.tf` file._

## Docker registry
This is required for storing docker images of various application services.
1. Create new registry container in `TerraformDemo` resource group.
2. Enable Admin user in Access Keys section of newly created registry.
3. Note Login server, username and password.

## Setting up GitHub Actions
Populate following secrets in repository settings:
SECRET | Value
-|-
`DOCKER_PASSWORD` | Password from docker registry step #3
`DOCKER_REGISTRY` | Login server from docker registry step #3
`DOCKER_USERNAME` | Username from docker registry step #3
`ARM_ACCESS_KEY` | Access key to storage account
`ARM_CLIENT_ID` | Azure application client identifier
`ARM_CLIENT_SECRET` | Azure application client secret
`ARM_SUBSCRIPTION_ID` | Azure subsription identifier
`ARM_TENANT_ID` | Azure application tenant identifier

_NOTE: To run Terraform locally above secrets must be set as environment variables._

## Terraform configuration
1. Edit `config_application.tf` to change application name (used as prefix), geographic location used for Azure resources or docker image.
2. Edit `config_environments.tf` to fine tune various things for each environment.

# Using terraform

## Environments
Each environment is a Terraform workspace.
Command | Meaning
-|-
`terraform workspace new foo` | Creates new workspace named `foo`
`terraform workspace select foo` | Selects workspace named `foo`
`terraform workspace delete foo` | Deletes workspace named `foo` (state must be empty)

## Applying infrastructure changes
It is advised to run `terraform plan` first to have better understanding what Terraform will do. Then run `terraform apply` to apply infrastructure changes.