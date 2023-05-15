provider "flux" {
  kubernetes = {
    config_path = "~/tf-flux-provider-test/environments/limnocentral/kubeconfig-temp.yaml"
  }
  git = {
    url = "ssh://git@github.com/${var.username}/fleet-infra"
    ssh = {
      username    = "git"
      private_key = "${file(var.private_key_pem_path)}"
    }
  }
}

terraform {
  required_version = ">= 1.1.5"
  required_providers {
    flux = {
      source = "registry.terraform.io/fluxcd/flux"
      version = "1.0.0-rc.3"
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = "clusters/test/limnocentral"
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]
}
