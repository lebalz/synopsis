# Grafana

Deploy the latest grafana dashboard and connect to prometheus over a local (intern) docker network.

```sh
APP=grafana
MAIL=foor@bar.ch
# a local (intern) network to communicate directly with prometheus
NETWORK=metric-network

dokku apps:create $APP
mkdir -p /var/lib/dokku/data/storage/$APP/grafana
sudo chown 472:472 /var/lib/dokku/data/storage/$APP/grafana
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/grafana:/var/lib/grafana


# optional: when running on the same host as prometheus: attach to a local network
dokku network:set $APP attach-post-deploy $NETWORK
dokku network:set $APP bind-all-interfaces true


# configuration file
touch /var/lib/dokku/data/storage/$APP/custom.ini
```

Edit the `custom.ini` File on the dokku server.

```sh
# edit your ini file, e.g. add oauth providers or set the root url
dokku storage:mount $APP /var/lib/dokku/data/storage/$APP/custom.ini:/etc/grafana/grafana.ini


# set port mapping
dokku proxy:ports-add $APP "http:80:3000"

# get the latest tag from https://hub.docker.com/r/grafana/grafana/tags
dokku git:from-image $APP grafana/grafana:7.5.2

# letsencrypt
dokku config:set --no-restart $APP DOKKU_LETSENCRYPT_EMAIL=$MAIL
dokku letsencrypt:enable $APP
```

## Setup Prometheus

Login to grafana and configure a datasource. The address within the local Docker-Network will be `http://prometheus.web:9090`.


## upgrade to the latest image

Get the latest tag from [releases](https://hub.docker.com/r/grafana/grafana/tags) and run

```sh
APP=grafana
dokku git:from-image $APP grafana/grafana:7.5.3
```