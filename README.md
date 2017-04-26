# Konakart + Docker + Dynatrace Appmon
Repo designed to automate deploying + scaling a dockerized konakart application instrumented with Dynatrace Appmon.

[Konakart](https://www.konakart.com)<br>
[Dynatrace Docker components](https://github.com/Dynatrace/Dynatrace-Docker)<br>

## Installation
Download konakart installer<br>
`curl -SL http://www.konakart.com/kkcounter/click.php?id=5 -o ./app/konakart-installation`<br>
`chmod +x /app/konakart-installation`

Launch Dynatrace Server, collector and agent<br>
`cd Dynatrace_Docker`<br>
`docker-compose up -d`

Configure system profile through client:<br>
    Note: agent name is currently hardcoded in startkonakart.sh so set the agent mapping to tomcat_Konakart (or update this).<br>
    TODO: Environment variable for this... or catalina.sh run<br> 

Launch Konakart: app server, db, load balancer<br>
`cd ..`<br>
`docker-compose up -d`

Scale app server (load balancer auto-adapts)<br>
`docker-compose scale konakart_app=x`

### System dependencies
* docker
* docker-compose
* curl

### Known issues
The mysql image used for this (beantoast... from lab document) has an issue where the DB and Konakart_App don't quite align (old version).<br>
TODO: Setup a new DB through base mysql image
