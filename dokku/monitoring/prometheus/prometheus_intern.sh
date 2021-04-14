#!/bin/bash
APP=prometheus
NETWORK=$APP

dokku apps:create $APP

 # create network
if [[ ! "$(dokku network:list)" =~ "$NETWORK" ]] ; then dokku network:create $NETWORK ; fi

# attach the network to the app - it will be available under the ip $APP.web
dokku network:set $APP attach-post-deploy $NETWORK

# create storage mounts for configs and data
mkdir -p  /var/lib/dokku/data/storage/$APP/config
mkdir -p  /var/lib/dokku/data/storage/$APP/data

# use correct owner for mounts
sudo chown -R nobody:nogroup /var/lib/dokku/data/storage/$APP

# mount
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/config:/etc/prometheus
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/data:/prometheus

# add configs
touch /var/lib/dokku/data/storage/$APP/config/alert.rules
touch /var/lib/dokku/data/storage/$APP/config/prometheus.yml


# disable proxy (not needed for intern use)
dokku proxy:disable $APP

# add content from prometheus.yml here...!
# scp dokku/prometheus/prometheus.yml root@188.34.157.212:/var/lib/dokku/data/storage/$APP/config/prometheus.yml
# scp root@188.34.157.212:/var/lib/dokku/data/storage/$APP/config/prometheus.yml dokku/prometheus/.prometheus.yml 

# deploy, get the latest tag from https://hub.docker.com/r/prom/prometheus
dokku git:from-image $APP prom/prometheus:v2.25.2