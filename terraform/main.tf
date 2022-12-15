module "blue-green-app"{
    source = "./modules/blue-green-app"
    applications =local.data
    host=local.hostname
    path=local.url_path
    path_type = local.path-type
    service_type = local.service-type
    ingress_class_name = local.nginx

}

