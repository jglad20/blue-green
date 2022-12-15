resource "kubernetes_ingress_v1" "main-ingress" {
  depends_on = [kubernetes_deployment.application-deployment, kubernetes_service.application-services]
  metadata {
    name = var.applications[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = var.path
    }
  }
  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      http {
        path {
          backend {
            service {
              name = var.applications[0].name
              port {
                number = var.applications[0].port
              }
            }
          }
          path = var.path
          path_type = var.path_type
        }
      }
      host = var.host
    }
  }
}


resource "kubernetes_ingress_v1" "canary-weighted-rules" {
  depends_on = [kubernetes_deployment.application-deployment, kubernetes_service.application-services]
  count = length(var.applications) - 1
  metadata {
    name = var.applications[count.index + 1 ].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = var.path
      "nginx.ingress.kubernetes.io/canary" = "true",
      "nginx.ingress.kubernetes.io/canary-weight" = var.applications[count.index ].traffic_weight
    }
  }
  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      http {
        path {
          backend {
            service {
              name = var.applications[count.index + 1 ].name
              port {
                number = var.applications[count.index + 1 ].port
              }
            }
          }
          path = var.path
          path_type = var.path_type
        }
      }
      host = var.host
    }
  }
}