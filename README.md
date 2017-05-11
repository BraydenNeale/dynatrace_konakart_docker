# Konakart + Docker + Dynatrace
Repo designed to automate deploying + scaling a dockerized konakart application using kubernetes and monitored by Dynatrace.

[Konakart](https://www.konakart.com)<br>

## Installation
### For building and deploying the docker image refer to one of the docker branches [or just pull my image](https://hub.docker.com/r/braydenneale/konakart/)
### Konakart on Google cloud - with cloud SQL
* Create a new project on Google cloud and a GKE cluster for it: [how?](https://deis.com/blog/2016/first-kubernetes-cluster-gke/)
* Create a new SQL instance [how?](https://cloud.google.com/sql/docs/mysql/create-instance) 
* Create a DB service account, set environment keys, .yml config for DB connection [how?](https://cloud.google.com/sql/docs/mysql/connect-container-engine) 
* Create the deployment to launch the defined pods `kubectl create -f konakart_app.yml`
* Create a service to connect externally to the cluster `kubectl expose deployment konakart-web --type=LoadBalancer`
* Connect to your external IP address and port show via `kubectl get services`
* Scale up or down: `kubectl scale deployment konakart-web --replicas x`

### Dynatrace oneagent monitoring
* Replace all 'REPLACE\_WITH' strings in dynatrace-oneagent.yaml with your DT credentials - [dynatrace oneagent kubernetes](https://help.dynatrace.com/infrastructure-monitoring/containers/how-do-i-run-oneagent-with-kubernetes/)<br>
[What are my credentials?](https://help.dynatrace.com/infrastructure-monitoring/containers/how-do-i-deploy-dynatrace-as-docker-container/#locate-your-dynatrace-environment-credentials)
* Restart (delete and recreate) your deployment and service<br>
`kubectl delete deployment konakart-web`
`kubectl delete service konakart-web`

##### useful commands to verify things...
* `kubectl get deployments`
* `kubectl get secrets`
* `kubectl get services`
* `kubectl describe pod [PODNAME]`

### System dependencies

### Known issues
