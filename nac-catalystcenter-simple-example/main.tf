terraform {
  required_providers {
    catalystcenter = {
      source  = "CiscoDevNet/catalystcenter"
      version = "0.4.5"
    }
  }
}

provider "catalystcenter" {
  username    = "admin"
  password    = "C1sco12345"
  url         = "https://198.18.129.100"
  max_timeout = 600
}

module "catalyst_center" {
  source  = "netascode/nac-catalystcenter/catalystcenter"
  version = "0.3.0"

  yaml_directories = ["data/"]
}