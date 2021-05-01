#!/bin/bash

APP=push-gateway
MAIL=foo@bar.ch
NETWORK=metric-network

dokku apps:create $APP

if [[ ! "$(dokku network:list)" =~ "$NETWORK" ]] ; then dokku network:create $NETWORK ; fi

# attach the network to the app - it will be available under the ip $APP.web
dokku network:set $APP attach-post-deploy $NETWORK

# add port mapping
dokku proxy:ports-set $APP "http:80:9091"
dokku domains:add $APP "push-gateway.dokkiu.me"

# deploy, get the latest tag from https://hub.docker.com/r/prom/pushgateway
dokku git:from-image $APP prom/pushgateway:v1.4.0


# letsencrypt
dokku config:set --no-restart $APP DOKKU_LETSENCRYPT_EMAIL=$MAIL
dokku letsencrypt $APP

# set up authentication
USER='admin'
PW="super-strong-pw"
dokku http-auth:on $APP $USER $PW
