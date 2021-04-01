#!/bin/bash

dokku apps:create cadvisor

# mount directories needed to monitor this node
dokku storage:mount cadvisor /:/rootfs:ro 
dokku storage:mount cadvisor /sys:/sys:ro 
dokku storage:mount cadvisor /var/lib/docker:/var/lib/docker:ro 
dokku storage:mount cadvisor /var/run:/var/run:rw

# set port mapping
dokku proxy:ports-add cadvisor "http:80:8080"

# get the latest tag from https://github.com/google/cadvisor/releases/
dokku git:from-image cadvisor gcr.io/cadvisor/cadvisor:v0.39.0

# letsencrypt
dokku config:set --no-restart cadvisor DOKKU_LETSENCRYPT_EMAIL=foo@bar.ch
dokku letsencrypt cadvisor

# set up authentication
dokku http-auth:on cadvisor admin your-strong-password