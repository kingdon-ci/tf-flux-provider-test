provider "flux" {
  config_path = "~/tf-flux-provider-test/environments/howard-stage/kubeconfig-temp.yaml"
}

terraform {
  required_version = ">= 1.1.5"
  required_providers {
    flux = {
      source = "registry.terraform.io/fluxcd/flux"
      # version = "0.24.0"
    }
  }
}

resource "flux_bootstrap_git" "this" {
  url = "ssh://git@github.com/${var.username}/fleet-infra"
  path = "clusters/howard-stage"
  ssh = {
    username    = "git"
    private_key = "${file(var.private_key_pem_path)}"
  }
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller"
  ]
}
