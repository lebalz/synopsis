#!/bin/bash

# the same as configured in prometheus...
NETWORK=prometheus
APP=cadvisor

dokku apps:create $APP

# mount directories needed to monitor this node
dokku storage:mount $APP /:/rootfs:ro 
dokku storage:mount $APP /sys:/sys:ro 
dokku storage:mount $APP /var/lib/docker:/var/lib/docker:ro 
dokku storage:mount $APP /var/run:/var/run:rw

# attach the prometheus network
dokku network:set $APP attach-post-deploy $NETWORK

dokku config:set $APP DOKKU_DOCKERFILE_START_CMD="-port=8080 -housekeeping_interval=10s dokku/$APP:latest"

# get the latest tag from https://github.com/google/cadvisor/releases/
dokku git:from-image $APP gcr.io/cadvisor/cadvisor:v0.39.0

