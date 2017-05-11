# Konakart + Docker + Dynatrace
Repo designed to automate deploying + scaling a dockerized konakart application using kubernetes and monitored by Dynatrace.

[Konakart](https://www.konakart.com)<br>

## Installation
### For building and deploying the docker image refer to the *dockerbuild* branch<br> 
[...or just pull my image](https://hub.docker.com/r/braydenneale/konakart/)
### Konakart on Google cloud - with cloud SQL
* Create a new project on Google cloud and a GKE cluster for it: [how?](https://deis.com/blog/2016/first-kubernetes-cluster-gke/)
* Create a new SQL instance [how?](https://cloud.google.com/sql/docs/mysql/create-instance) 
* Create a DB service account, set environment keys, .yml config for DB connection [how?](https://cloud.google.com/sql/docs/mysql/connect-container-engine) 
* Create the deployment to launch the defined pods `kubectl create -f konakart_app.yml`
* Create a service to connect externally to the cluster `kubectl expose deployment konakart-web --type=LoadBalancer`
* Connect to your external IP address and port show via `kubectl get services`
* Scale deployment up or down: `kubectl scale deployment konakart-web --replicas x`
* Autoscale cluster up or down based on cpu threshold: `kubectl autoscale deployment konakart-web --cpu-percent=80 --min=1 --max=5`

### Dynatrace oneagent monitoring
* Simply replace all 'REPLACE_WITH' strings in dynatrace-oneagent.yaml with your DT credentials<br>
* Create one agent Daemon set: `kubectl create -f dynatrace-oneagent.yaml`<br>
* ... that's it you're done
[dynatrace oneagent kubernetes](https://help.dynatrace.com/infrastructure-monitoring/containers/how-do-i-run-oneagent-with-kubernetes/)<br>
[What are my credentials?](https://help.dynatrace.com/infrastructure-monitoring/containers/how-do-i-deploy-dynatrace-as-docker-container/#locate-your-dynatrace-environment-credentials)

##### useful commands to verify things...
* `kubectl get deployments`
* `kubectl get secrets`
* `kubectl get services`
* `kubectl describe pod [PODNAME]`

##### Environment variables
* **DB_TYPE**: e.g mysql
* **DB_DRIVER**: db driver for connection e.g. com.mysql.jdbc.Driver
* **DB_HOST**: ip or host name to connect to
* **DB_PORT**: port to connect to
* **DB_NAME**: konakart requires an existing DB to connect to... must be created beforehand
* **DB_LOAD**: Boolean value for auto seeding the DB with test data (manual seeding beforehand is better -> as load has issues with scaling)
* **DB_OPTIONS**: Additional connection options - refer to konakart docs e.g. useSSL
* **DB_USER**: user account to use to connect to the DB (recommended to store within secrets in kubernetes)
* **DB_PWD**: password for db user account (store within kubernetes secrets)

TODO: Env vars for DT oneagent connection tokens

### System dependencies

### Known issues
