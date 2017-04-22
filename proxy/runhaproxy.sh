if [ ! -s "/etc/haproxy/dtkonakart_proxy.cfg" ]; then
	#Set default application name
	if [ -z "$APP_NAME"  ]; then
		APP_NAME="konakart"
		echo 'appname is set to "appname"'
	fi
	txt="\nlisten $APP_NAME 0.0.0.0:80\n\tmode http\n\tstats enable\n\tstats uri /haproxy?stats\n\tstats realm Strictly\\ Private\n\tstats auth"
	#Set admin default name and password
	if [ -z "$ADMIN_UNAME" ] || [ -z "$ADMIN_PWD" ]; then
		ADMIN_UNAME="admin"
		ADMIN_PWD="admin"
		echo 'admin auth set to default'
		fi
	txt="$txt $ADMIN_UNAME:$ADMIN_PWD\n\tbalance roundrobin\n\toption httpclose\n\toption forwardfor"
	
	if [ -z "$SERVER1" ] && [ -z "$SERVER2" ] && [ -z "$SERVER3" ] && [ -z "$SERVER4" ]; then
		echo "At least 1 server need to be defined. Exiting ..."
		exit 1
	fi

	#Check for servers (currently 4 servers max)
	if [ ! -z "$SERVER1" ]; then
		txt="$txt \n\tserver server1 $SERVER1 check"
		echo 'server 1 is set to $SERVER1'
	fi

	if [ ! -z "$SERVER2" ]; then
		txt="$txt \n\tserver server2 $SERVER2 check"
		echo 'server 2 is set to $SERVER1'
	fi

	if [ ! -z "$SERVER3" ]; then
		txt="$txt \n\tserver server3 $SERVER3 check"
		echo 'server 3 is set to $SERVER3'
	fi

	if [ ! -z "$SERVER4" ]; then
		txt="$txt \n\tserver server1 $SERVER4 check"
		echo 'server 4 is set to $SERVER4'
	fi
	echo -e $txt
	echo -e $txt > /opt/dtkonakart_proxy.cfg
fi

#Run the proxy
#The tail is needed in this case because Docker will stop if nothing is running the foreground
service haproxy start
haproxy -f /etc/haproxy/haproxy.cfg -f /opt/dtkonakart_proxy.cfg
tail -f /opt/dtkonakart_proxy.cfg

