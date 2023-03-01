resource "nirmata_cluster_registered" "oke-registered" {
  name         = "oke-oci-cluster"
  cluster_type = "default-add-ons"
}

terraform {
  required_providers {

    nirmata = {
      source  = "nirmata/nirmata"
      version = "1.1.8-rc2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "oci" {
  region = "us-ashburn-1"
}


provider "kubectl" {
  config_path = "/Users/nirmata/trinet-oke/oke-private-tf/examples/oke-native-pod-ips/oke_cluster_kubeconfig"
}


resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "kubectl config use-context $(kubectl config get-contexts --kubeconfig /Users/nirmata/trinet-oke/oke-private-tf/examples/oke-native-pod-ips/oke_cluster_kubeconfig --no-headers -o name) --kubeconfig /Users/nirmata/trinet-oke/oke-private-tf/examples/oke-native-pod-ips/oke_cluster_kubeconfig"
  }
}

// configure the Nirmata provider
provider "nirmata" {

  // Nirmata address.
  url = "https://nirmata.io"

  // Nirmata API Key. Also configurable using the environment variable NIRMATA_TOKEN.
  token = "QO+8pTZA51ib4baB9NnnzZDrmqANgnHhH94EgemozPowAunzWWChw43SNCsILdaaBXzBATwXRvalRWocV/JOPA=="
}

data "kubectl_filename_list" "manifests" {
  pattern = "${nirmata_cluster_registered.oke-registered.controller_yamls_folder}/*"
}

// apply the controller YAMLs
resource "kubectl_manifest" "test" {
  count     = nirmata_cluster_registered.oke-registered.controller_yamls_count
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}
