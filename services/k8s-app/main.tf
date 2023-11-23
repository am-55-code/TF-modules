terraform {
  required_version = ">=1.1.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

locals {
  pod_labels = {
    app = var.name
  }
}

# K8s deployment to run an app
resource "kubernetes_deployment" "app" {

  metadata {
    name = var.name
  }

  spec {
    replicas = var.replicas

    template {
      metadata {
        labels = local.pod_labels
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = var.container_port
          }

          dynamic "env" {
            for_each = var.environment_variables

            content {
              name  = env.key
              value = env.value
            }

          }
        }
      }
    }
    selector {
      match_labels = local.pod_labels
    }
  }
}

# Creating a K8s service to deploy a LB in front of the app
resource "kubernetes_service" "app" {
    metadata {
      name = var.name
    }
    spec {
      type = "LoadBalancer"
      
      port {
        port = 80
        target_port = var.container_port
        protocol = "TCP"
      }
      selector = local.pod_labels
    }  
}
