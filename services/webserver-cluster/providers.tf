# Configure the Microsoft Azure Provider
terraform {
  backend "azurerm" {
    key = "${var.state_file_remote_key}.tfstate"
  }
}