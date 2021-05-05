# Ledokku

## [Website](https://www.ledokku.com/)

## Installation

```sh
dokku apps:create ledokku
mkdir -p /var/lib/dokku/data/storage/ledokku/ssh

dokku storage:mount ledokku /var/lib/dokku/data/storage/ledokku/ssh/:/root/.ssh
chown dokku:dokku /var/lib/dokku/data/storage/ledokku/ssh

# if redis is not installed:
# dokku plugin:install https://github.com/dokku/dokku-redis.git redis
dokku redis:create ledokku
dokku redis:link ledokku ledokku

dokku postgres:create ledokku
dokku postgres:link ledokku ledokku

# create github tenant: https://github.com/settings/developers
dokku config:set ledokku GITHUB_CLIENT_ID="...."
dokku config:set ledokku GITHUB_CLIENT_SECRET="...."

# prepare config
dokku config:set ledokku DOKKU_SSH_HOST="the-real-server-ip, not host name!"
dokku config:set ledokku JWT_SECRET=$(openssl rand -hex 32)
dokku config:set ledokku TELEMETRY_DISABLED=1

dokku git:from-image ledokku ledokku/ledokku:0.5.1
dokku proxy:ports-add ledokku http:80:4000
dokku proxy:ports-remove ledokku http:4000:4000

# letsencrypt
dokku config:set --no-restart ledokku DOKKU_LETSENCRYPT_EMAIL="your@mail.web"
dokku letsencrypt:enable ledokku
```
