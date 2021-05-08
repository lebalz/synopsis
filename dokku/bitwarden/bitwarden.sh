#!/bin/bash
APP=bitwarden
MAIL=foor@bar.ch
DOMAIN=bitwarden.dokku.me


dokku apps:create $APP
mkdir -p /var/lib/dokku/data/storage/$APP/data
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/data:/data/

# set port mapping
dokku proxy:ports-add $APP "http:80:80"
# set domain
dokku domains:add $APP $DOMAIN

# SMTP configuration
dokku config:set $APP DOMAIN=https://$DOMAIN
dokku config:set $APP SMTP_HOST=mail.gandi.net
dokku config:set $APP SMTP_FROM=foo@bar.ch
dokku config:set $APP SMTP_FROM_NAME=Bitwarden
dokku config:set $APP SMTP_PORT=587 
dokku config:set $APP SMTP_SSL=true
dokku config:set $APP SMTP_USERNAME=foo@bar.ch
dokku config:set $APP SMTP_PASSWORD=safe-pw

# enable admin route
dokku config:set $APP ADMIN_TOKEN=$(openssl rand -base64 48)

# for correct propagation of the clients ip:
dokku nginx:set $APP x-forwarded-for-value "\$proxy_add_x_forwarded_for"

# deploy
dokku git:from-image $APP vaultwarden/server:latest

# !! The following step has to be done after each deployment, since there
# is no possibility to set X-Real-IP to $remote_addr without a custom template,
# so edit your the nginx template under /home/dokku/$APP/nginx.conf and add
#   location / {
#       ...
#       X-Real-IP to $remote_addr;
#   }
#
service nginx reload


# letsencrypt
dokku config:set --no-restart $APP DOKKU_LETSENCRYPT_EMAIL=$MAIL
dokku letsencrypt $APP
