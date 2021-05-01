# Monitoring: Grafana + Prometheus + cAdvisor

This tutorial will guide you through the setup of a complete monitoring stack on dokku.

## 1. Prometheus

Start with creating prometheus. It's up to you whether prometheus shall be accessible intern only (no requests are proxied to the app), or to make it available to the internet.

[Guide for Prometheus](prometheus/README.md)


## 2. cAdvisor
[Guide for cAdvisor](cadvisor/README.md)

## 3. Grafana
[Guide for Grafana](grafana/README.md)

## 4. Loki
[Guide for Loki](loki/README.md)