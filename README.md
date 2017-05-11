# Konakart + Docker + Dynatrace
Repo designed to automate deploying + scaling a dockerized konakart application using kubernetes and monitored by Dynatrace.

[Konakart](https://www.konakart.com)<br>

## Installation
### For building and deploying the docker image refer to one of the docker branches [or just pull my image](https://hub.docker.com/r/braydenneale/konakart/)
### Google cloud - with cloud SQL
* Create a new project on Google cloud and a GKE cluster for it: [how?](https://deis.com/blog/2016/first-kubernetes-cluster-gke/)
* Create a new SQL instance [how?](https://cloud.google.com/sql/docs/mysql/create-instance) 
* Create a DB service account, set environment keys, .yml config for DB connection [how?](https://cloud.google.com/sql/docs/mysql/connect-container-engine) 
* Create the deployment to launch the defined pods `kubectl create -f konakart_app.yml`
* Create a service to connect externally to the cluster `kubectl expose deployment konakart-web --type=LoadBalancer`
* Scale up or down: `kubectl scale deployment konakart-web --replicas x`

##### useful commands to verify things...
* `kubectl get deployments`
* `kubectl get secrets`
* `kubectl get services`
* `kubectl describe pod [PODNAME]`

### System dependencies

### Known issues
