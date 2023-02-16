provider "flux" {
  config_path = "~/tf-flux-provider-test/kubeconfig-temp.yaml"
}

terraform {
  required_version = ">= 1.1.5"
  required_providers {
    flux = {
      source = "registry.terraform.io/fluxcd/flux"
    }
  }
}

resource "flux_bootstrap_git" "this" {
  url = "https://github.com/${var.username}/fleet-infra"
  http = {
    username = var.username
    password = var.password
  }
  path = "clusters/test/limnocentral"
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]
}
