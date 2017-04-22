FROM debian:jessie
MAINTAINER vu.pham

#Update the repository
RUN apt-get update

RUN apt-get install -y haproxy

#Add files to directories on Docker Container
CMD echo Adding installation script
ADD ./dtkonakart_proxy.cfg /opt/
ADD ./runhaproxy.sh /opt/

#Listen on default KonaKart port
EXPOSE 80

#Run proxy server
CMD /bin/bash /opt/runhaproxy.sh

