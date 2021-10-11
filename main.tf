# Get the necessary terraform providers
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.4.1"
    }
  }
}

# Declare terraform variables
variable "do_token" {
  description = "Digital Ocean Access Token"
  type = string
  sensitive = true
}
variable "cluster_name" {
  description = "A unique name for your cluster"
  type = string
}
# Configure DigitalOcean provider
provider "digitalocean" {
  token = var.do_token
}

# DigitalOcean Kubernetes Cluster
resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = var.cluster_name
  region  = "tor1"
  version = "1.21.3-do.0"

  node_pool {
    name       = "autoscale-worker-pool"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}
