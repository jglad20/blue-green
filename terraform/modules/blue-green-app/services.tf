resource "kubernetes_service" "application-services" {
  count= length(var.applications)
  metadata {
    name = var.applications[count.index].name
  }
  spec {
    selector = {
      app = var.applications[count.index].name
    }
    port {
      port        = var.applications[count.index].port
      target_port = var.applications[count.index].port
    }

    type = var.service_type
  }
}