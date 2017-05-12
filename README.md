# Konakart + Docker + Dynatrace Appmon
Repo designed to automate deploying + scaling a dockerized konakart application instrumented with Dynatrace Appmon.<br>
[Konakart](https://www.konakart.com)<br>
[Dynatrace Docker components](https://github.com/Dynatrace/Dynatrace-Docker)<br>

**Ask yourself... Should I just use Dynatrace SaaS/Managed for this?... Because the answer is YES**

## Installation
* Download konakart installer<br>
`curl -SL http://www.konakart.com/kkcounter/click.php?id=5 -o ./app/konakart-installation`<br>
`chmod +x /app/konakart-installation`

* Launch Dynatrace Server, collector and agent<br>
`cd Dynatrace_Docker`<br>
`docker-compose up -d`

* Configure system profile through the Dynatrace Appmon client:<br>
    Note: agent name is currently hardcoded in startkonakart.sh so set the agent mapping to tomcat_Konakart (or update this).<br>
    TODO: Environment variable for this... or catalina.sh run<br> 

* Launch Konakart: app servers, db, load balancer<br>
`cd ..`<br>
`docker-compose scale konakart_app=4` (only have 4 Tcp ports set - LB needs to know about all of them)<br>
`docker-compose up -d`

* Scale app server (load balancer auto-adapts)<br>
`docker-compose scale konakart_app=x` (where 1 <= x <= 4)

### System dependencies
* docker
* docker-compose
* curl

### Known issues
The mysql image used for this (beantoast... from lab document) has an issue where the DB and Konakart_App don't quite align (old version).<br>
TODO: Setup a new DB through base mysql image - This has been done for the kubernetes workflow on other branches so refer to that if you want a working DB<br>

The legacy load balancer setup is not ideal... can only scale up to 4 app servers and have to specify different containers for them. This is solved when using compose version 2 as the LB uses the services... but I haven't found a way to configure the network to allow the konakart agent to connect to the collector in this version.  
