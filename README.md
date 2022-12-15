# Blue Green App Deployment using MiniKube
This repository contains manifests and terrform config files to demonstrate the blue-green deplyment strategy using Minikube.
It is assumed that the user will run this locally on his workstation.

## Pre-Requisites:
-  [Kubectl]((https://kubernetes.io/docs/tasks/tools/#kubectl)) installed. 
-  [MiniKube]((https://minikube.sigs.k8s.io/docs/start/)) installed .
- [Terraform]((https://developer.hashicorp.com/terraform/downloads)) installed .

## Execution via Kubectl:

To use kubectl and deploy the resources to your minikube cluster from the root folder run the following commands.

```sh
minikube start
kubectl apply -f ./deployments
```
This will deploy all the manifests contained in the deployments folder.
To now verify that this was applied correctly we need to do the following:

- On Windows and macOS Minikube needs a tunnel to connect to the services 
This terminal where we run needs to be always running in the foreground

```sh
minikube tunnel
```
Depending on your Opearting System you need to update the hosts file with the hostname that you want to resolve.
- For Windows/macOS as we establish a tunnel  we will use `127.0.0.1` and the `hostname` the entry to be added
Example : `127.0.0.1 my-ingress-host`
- For Linux systems we will add the entry with the value returned by the command `minikube ip` and the `hostname` we need to resolve to.
 
We can now open the hostname that we added to the hosts file and see the text returned. YOu can either use the browser or use a CLI command like cURL.
```sh
curl -Lk <hostname>
```
 To cleanup : 
 ```sh
kubectl delete -f ./deployments
```
## Execution via Terraform:

To acheive the same using terraform run the following commands.
Ensure that minikube is running and that the tunnel is created as described above if you are on Windows/macOs.

```sh
cd terraform
terraform init
terraform plan -out plan
terraform apply "plan"
```

To cleanup :

```sh
terraform destroy --auto-approve
```

## Further Reading:

The weighted routing of requests to the applications is done uisng canary release or deployment.
- https://www.nginx.com/blog/microservices-march-improve-kubernetes-uptime-and-resilience-with-a-canary-deployment/
- https://v2-1.docs.kubesphere.io/docs/quick-start/ingress-canary/


## License:

MIT



