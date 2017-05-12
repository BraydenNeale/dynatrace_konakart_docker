# Konakart + Docker
Repo designed to automate building of a configurable konakart docker-image and running it through docker compose

[Konakart](https://www.konakart.com)<br>

## Installation
* Download konakart installer<br>
`curl -SL http://www.konakart.com/kkcounter/click.php?id=5 -o ./app/konakart-installation`<br>
`chmod +x app/konakart-installation`
* Run and build/pull Konakart images: konakart-app, mysql, HA proxy<br>
Replace example env vars in *./app* (*konakart.env*, *mysql.env*) with your own<br>
`docker-compose up -d`
* Scale app server (load balancer auto-adapts)<br>
`docker-compose scale konakart_app=x`

* Alternatively... just to build the konakart image<br>
`docker build -t [image_name] ./app/`

* Tag your image<br>
`docker tag [image_name] [repo + tag + version]`<br>
e.g. `docker tag konakart_app braydenneale/konakart:1.0.0`
* Create repo for image ... e.g. on dockerhub
* Push to a remote repo<br>
`docker login`<br>
`docker push [image_tag]`<br>
e.g. `docker push braydenneale/konakart:1.0.0`

### Environment Variables 
#### konakart.env
* **DB_TYPE**: e.g mysql
* **DB_DRIVER**: db driver for connection e.g. com.mysql.jdbc.Driver
* **DB_HOST**: ip or host name to connect to
* **DB_PORT**: port to connect to
* **DB_NAME**: konakart requires an existing DB to connect to... must be created beforehand (should = MYSQL_DATABASE)
* **DB_LOAD**: Boolean value for auto seeding the DB with test data (manual seeding beforehand is better -> as load has issues with scaling)
* **DB_OPTIONS**: Additional connection options - refer to konakart docs e.g. useSSL
* **DB_USER**: user account to use to connect to the DB
* **DB_PWD**: password for db user account (should = MYSQL_ROOT_PASSWORD, if using the root user)

#### mysql.env - [image overview](https://hub.docker.com/_/mysql/)
* **MYSQL_ROOT_PASSWORD**: root password to set for the DB
* **MYSQL_DATABASE**: Database to create on container startup 

### System dependencies
* docker
* docker-compose
* curl
