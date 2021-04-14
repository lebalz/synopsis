#!/bin/bash

APP=cadvisor
MAIL=foo@bar.ch

dokku apps:create $APP

# mount directories needed to monitor this node
dokku storage:mount $APP /:/rootfs:ro 
dokku storage:mount $APP /sys:/sys:ro 
dokku storage:mount $APP /var/lib/docker:/var/lib/docker:ro 
dokku storage:mount $APP /var/run:/var/run:rw

# start command
dokku config:set $APP DOKKU_DOCKERFILE_START_CMD="-housekeeping_interval=10s dokku/$APP:latest"

# get the latest tag from https://github.com/google/cadvisor/releases/
dokku git:from-image $APP gcr.io/cadvisor/cadvisor:v0.39.0

# letsencrypt
dokku config:set --no-restart $APP DOKKU_LETSENCRYPT_EMAIL=$MAIL
dokku letsencrypt $APP

# set up authentication
USER=admin
PW="your-strong-password"
dokku http-auth:on $APP $USER $PW


# advanced options
# dokku config:set $APP DOKKU_DOCKERFILE_START_CMD="-docker_only=true -port=8080 -housekeeping_interval=10s -raw_cgroup_prefix_whitelist=/docker/ -disable_root_cgroup_stats=true dokku/$APP:latest"
