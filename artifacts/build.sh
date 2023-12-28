while read DOMAIN ; do
	eval set -- "$DOMAIN"
	echo "server {
    listen 443 ssl;
    listen [::]:443 ssl;
    ssl_certificate /etc/letsencrypt/live/$1/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$1/privkey.pem;
    ssl_stapling on;
    ssl_stapling_verify on;
    add_header Strict-Transport-Security "max-age=31536000";
    access_log /var/log/nginx/sub.log combined;
    server_name $1;
    location /.well-known {
        alias /var/www/$1/.well-known;
    }
    location / {
        resolver 192.168.50.241;
	set \$next $2;
        proxy_pass http://\$next;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}" >> /artifacts/sites-available-default
done < /artifacts/domains
