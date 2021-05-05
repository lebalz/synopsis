#!/bin/bash
APP=loki
MAIL=foo@bar.ch
NETWORK=metric-network

dokku apps:create $APP

if [[ ! "$(dokku network:list)" =~ "$NETWORK" ]] ; then dokku network:create $NETWORK ; fi

# attach the network to the app - it will be available under the ip $APP.web
dokku network:set $APP attach-post-deploy $NETWORK

# create storage mounts for configs and data
mkdir -p  /var/lib/dokku/data/storage/$APP/config
mkdir -p  /var/lib/dokku/data/storage/$APP/data

# use correct owner for mounts
sudo chown -R nobody:nogroup /var/lib/dokku/data/storage/$APP

# mount
mkdir -p /var/lib/dokku/data/storage/$APP/config
touch /var/lib/dokku/data/storage/$APP/config/loki-config.yml
chown -R nobody:nogroup /var/lib/dokku/data/storage/$APP
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/config:/etc/loki

# add configs
dokku config:set --no-restart $APP DOKKU_DOCKERFILE_START_CMD="-config.file=/etc/loki/loki-config.yaml"
# add content from loki-config.yaml here...!
# scp dokku/prometheus/monitoring/loki-config.yaml root@188.34.157.212:/var/lib/dokku/data/storage/$APP/config/loki-config.yaml

# add port mapping
dokku proxy:ports-set $APP "http:80:3100"



# deploy, get the latest tag from https://hub.docker.com/r/grafana/loki/tags
dokku git:from-image $APP grafana/loki:2.2.1


# letsencrypt
dokku config:set --no-restart $APP DOKKU_LETSENCRYPT_EMAIL=$MAIL
dokku letsencrypt:enable $APP

# set up authentication
USER=admin
PW="your-strong-password"
dokku http-auth:on $APP $USER $PW
