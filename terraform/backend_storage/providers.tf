terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}



provider "aws" {
  # Configuration options
}

provider "azurerm" {
  # Configuration options
  features {}
}
