#!/bin/sh
# ================
#  Start KonaKart
# ================

# figure out where the home is - $0 may be a softlink

PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

KK_TOMCAT_BIN=`dirname "$PRG"`

export CATALINA_HOME=${KK_TOMCAT_BIN}/..
export CATALINA_BASE=${KK_TOMCAT_BIN}/..

export CATALINA_OPTS="-agentpath:/dynatrace/agent/lib64/libdtagent.so=name=tomcat_Konakart,server=dtcollector -Xmx1400m -Xms400m -XX:PermSize=256m -XX:MaxPermSize=256m -server -Dsolr.solr.home=${CATALINA_HOME}/solr -Djava.awt.headless=true -Dactivemq.store.dir=${CATALINA_HOME}/mq"

# SSL Protocols TLS 1.2
# If using Java 7 and using a Payment Gateway that requires TLS 1.2 you will probably need to add these to CATALIAN_OPTS or JAVA_OPTS:
# -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2"  -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2"

# Giving KonaKart more memory:
# You will probably want to use considerably more memory on 64' platforms - such as -Xmx4096m at least

# Logging debug options:    
# (Default is debug=false)
# for debugging log4j   add:  -Dlog4j.debug=true
# for debugging kklog4j add:  -Dkk.log4j.debug=true

# Logging java.net traffic
# -Djavax.net.debug=all

# Logging JAXWS processing:
# -Dcom.sun.xml.ws.transport.http.client.HttpTransportPipe.dump=true -Dcom.sun.metro.soap.dump=true

# To allow changes to logging without restarting:
# (Default is WatchTimeSecs=120)
# to disable the watch thread on log files set -Dkk.log4j.WatchTimeSecs=-1
# to enable  the watch thread on log files set -Dkk.log4j.WatchTimeSecs=60   to check for changes every 60 seconds

. ${KK_TOMCAT_BIN}/setJavaHome.sh

if [ ! -x "${CATALINA_HOME}/temp" ]; then
	mkdir ${CATALINA_HOME}/temp
fi

# These JAVA_OPTS (or similar) can be used when running the Java Message Queue Web Console (Enterprise Extensions)
# export JAVA_OPTS="-Dwebconsole.type=properties -Dwebconsole.jms.url=tcp://localhost:8791 -Dwebconsole.jmx.url=service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi -Dwebconsole.jmx.user= -Dwebconsole.jmx.password="

if [ -r "$CATALINA_BASE/solr/bin/solr" ]; then
	"$CATALINA_BASE/solr/bin/solr" start -p 8983
fi

${KK_TOMCAT_BIN}/startup.sh
