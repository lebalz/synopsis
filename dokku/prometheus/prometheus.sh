#!/bin/bash

dokku apps:create prometheus

# create storage mounts for configs and data
mkdir -p  /var/lib/dokku/data/storage/prometheus/config
mkdir -p  /var/lib/dokku/data/storage/prometheus/data

# use correct owner for mounts
sudo chown -R nobody:nogroup /var/lib/dokku/data/storage/prometheus

# mount
dokku storage:mount prometheus /var/lib/dokku/data/storage/prometheus/config:/etc/prometheus
dokku storage:mount prometheus /var/lib/dokku/data/storage/prometheus/data:/prometheus

# add configs
touch /var/lib/dokku/data/storage/prometheus/config/alert.rules
touch /var/lib/dokku/data/storage/prometheus/config/prometheus.yml
# add content from prometheus.yml here...!

# add port mapping
dokku proxy:ports-set prometheus "http:80:9090"

# deploy, get the latest tag from https://hub.docker.com/r/prom/prometheus
dokku git:from-image prometheus prom/prometheus:v2.25.2

# letsencrypt
dokku config:set --no-restart prometheus DOKKU_LETSENCRYPT_EMAIL=foo@bar.ch
dokku letsencrypt prometheus