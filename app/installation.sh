if [ ! -f /usr/local/konakart ]; then
	#Run manual KonaKart installation
        /tmp/konakart-installation -S \
            -DDatabaseType "$DB_TYPE" \
            -DDatabaseDriver "$DB_DRIVER" \
            -DDatabaseUrl jdbc:"$DB_TYPE"://"$DB_HOST":"$DB_PORT"/"$DB_NAME"?"$DB_OPTIONS" \
            -DDatabaseUsername "$DB_USER" \
            -DDatabasePassword "$DB_PWD"  \
            -DLoadDB "$DB_LOAD"

	sleep 10s	
	echo "...... Finished installing."
fi
echo "Starting...."

#Run the KonaKart application
#The tail is needed in this case because Docker will stop if nothing is running the foreground
/bin/sh /usr/local/konakart/bin/startkonakart.sh
tail -f /usr/local/konakart/logs/catalina.out

