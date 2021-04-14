# cAdvisor

[cAdvisor](https://github.com/google/cadvisor) to report container metrics to prometheus.


There are two different versions - one that exposes the metrics to a local network, accessible only on the same dokku host, and a version which can be accessed from the outside.

- [intern accessible](cadvisor_intern.sh)
- [public accessible](cadvisor_public.sh)

## upgrade
Get the latest version from the [release page](https://github.com/google/cadvisor/releases/) and run

```sh
APP=cadvisor
dokku git:from-image $APP gcr.io/cadvisor/cadvisor:v0.39.0 # or whatever tag is latest...
```