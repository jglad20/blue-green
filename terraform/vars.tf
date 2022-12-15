    locals{
        data=jsondecode(file("${path.module}/applications.json")).applications
        hostname="my-ingress-host"
        path-type="Prefix"
        service-type="NodePort"
        url_path="/"
        nginx="nginx"
    }