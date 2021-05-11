# RAM memory exporter

Since the ram reporting of cadvisor is not precise but an additional instance of node-exporter is too heavy, we use a simple bash script that reports the ram usage to prometheus pushgateway.

## Create a systemd service and timer to execute the ram export periodically



```sh
# copy script
cp memory_exporter.sh /usr/local/bin/memory_exporter.sh
chmod 744 /usr/local/bin/memory_exporter.sh

# copy service
cp memory_exporter.service /etc/systemd/system/memory_exporter.service
chmod 664 /etc/systemd/system/memory_exporter.service

# copy timer
cp memory_exporter.time /etc/systemd/system/memory_exporter.time
chmod 664 /etc/systemd/system/memory_exporter.timer

# reload systemd services
systemctl daemon-reload

# enable service
systemctl enable memory_exporter.timer
# start service
systemctl start memory_exporter.timer

# report timers & services
systemctl status memory_exporter.timer
systemctl list-timers --all
```