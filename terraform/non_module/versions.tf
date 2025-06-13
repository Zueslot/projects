terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.31.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.4.0"
    }
  }
  # backend "s3" {
  #   bucket = "ghdsdjdhjd"
  #   key    = "path/key"
  #   region = "us-east-2"
  # }

  backend "azurerm" {
    use_cli              = true                                   # Can also be set via `ARM_USE_CLI` environment variable.
    use_azuread_auth     = true                                   # Can also be set via `ARM_USE_AZUREAD` environment variable.
    tenant_id            = "f904cfb7-ace9-455d-99ff-889572baa366" # Can also be set via `ARM_TENANT_ID` environment variable. Azure CLI will fallback to use the connected tenant ID if not supplied.
    storage_account_name = "zeus123xyz"                           # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfcontainer"                          # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "Prod.statefile"                         # Name you want for your backend file in the container
  }
}



provider "azurerm" {
  subscription_id = "9db02152-2d31-40f6-8c18-107c13bca52b"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  } # Configuration options
}

provider "tls" {
  # Configuration options
}

provider "local" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

provider "azuread" {
  # Configuration options
}
