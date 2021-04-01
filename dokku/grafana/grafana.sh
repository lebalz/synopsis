#!/bin/bash

dokku apps:create grafana
mkdir -p /var/lib/dokku/data/storage/grafana/grafana
sudo chown 472:472 /var/lib/dokku/data/storage/grafana/grafana
dokku storage:mount grafana /var/lib/dokku/data/storage/grafana/grafana:/var/lib/grafana

# configuration file
touch /var/lib/dokku/data/storage/grafana/custom.ini
# edit your ini file, e.g. add oauth providers or set the root url
dokku storage:mount grafana /var/lib/dokku/data/storage/grafana/custom.ini:/etc/grafana/grafana.ini


# set port mapping
dokku proxy:ports-add grafana "http:80:3000"

# get the latest tag from https://hub.docker.com/layers/grafana/grafana
dokku git:from-image grafana grafana/grafana:7.5.2

# letsencrypt
dokku config:set --no-restart prometheus DOKKU_LETSENCRYPT_EMAIL=foo@bar.ch
dokku letsencrypt prometheus

# initial pw for user admin: admin
