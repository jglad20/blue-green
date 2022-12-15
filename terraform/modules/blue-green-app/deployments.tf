resource "kubernetes_deployment" "application-deployment" {
    count= length(var.applications)
    metadata{
        name=var.applications[count.index].name
        labels = {
            app = var.applications[count.index].name
      }
    }
    spec {
    replicas = var.applications[count.index].replicas
    selector {
      match_labels = {
        app = var.applications[count.index].name
      }
    }
    template {
      metadata {
        labels = {
          app = var.applications[count.index].name
        }
      }
      spec {
        container {
          image = var.applications[count.index].image
          name  = var.applications[count.index].name
          port {
            container_port = var.applications[count.index].port
          }
          args = ["-listen=:${var.applications[count.index].port}", "-text='I am ${var.applications[count.index].name}'"]
        }
      }
    }
    }
}