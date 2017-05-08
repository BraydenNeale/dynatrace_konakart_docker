FROM debian:jessie
MAINTAINER vu.pham

#Update the repository
RUN apt-get update

#Install Java Runtime Environment for KonaKart
RUN apt-get install -y openjdk-7-jre

#Add files to directories on Docker Container
CMD echo Adding installation script
ADD ./installation.sh /opt/
ADD ./konakart-installation /tmp/

#Listen on default konakart port
EXPOSE 8780

#Run konakart
CMD /bin/bash /opt/installation.sh

#Example usage:
# sudo docker run -d -p 8080:8780 --name konakart_app -e DB_ADDRESS=x.x.x.x -e DB_PORT=PORT –e repository_name

