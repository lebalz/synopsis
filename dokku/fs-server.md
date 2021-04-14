# FS Info Server

Runs [dokku](https://dokku.com/), the smallest PaaS.

## Conventions

- personal apps starts with abbrevs, e.g. `hfr-socketio-server`
- general apps don't have an abbrev - they should not be removed without asking the others

# dokku plugins

dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku plugin:install https://github.com/dokku/dokku-http-auth.git
dokku plugin:install https://github.com/lebalz/dokku-post-deploy-script post-deploy-script
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
dokku plugin:install https://github.com/dokku/dokku-redis.git redis
