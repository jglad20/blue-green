terraform {
 required_version = ">= 1.3.2"
 
 required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
   
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}