terraform {
  required_providers {
    oci = {
        source  = "oracle/oci"
        version = ">=4.67.3"
    }
  }
  cloud {
    organization = "rafaelbaumann"
    workspaces {
      name = "sre-pocket"
    }
  }
}

provider "oci" {
  region = var.region
}