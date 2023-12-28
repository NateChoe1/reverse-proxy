#!/bin/sh

if [ -z "$CERTBOT_AGREE" ] ; then
	echo "Set CERTBOT_AGREE=y in your docker-compose.yml"
	exit 1
fi

mv /artifacts/sites-available-default /etc/nginx/conf.d/default.conf

nginx -g "daemon on;"
while read DOMAIN ; do
	eval set -- "$DOMAIN"
	if ! [ -d /etc/letsencrypt/live/$1 ] ; then
		certbot --nginx -d $1 -m "$(cat /artifacts/email)" -n
	fi
done < /artifacts/domains
nginx -s stop

touch /var/log/cron.log
crontab /artifacts/crons.cron && tail -f /var/log/cron.log &
cron

nginx -g "daemon off;"
