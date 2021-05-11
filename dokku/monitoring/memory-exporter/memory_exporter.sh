#!/bin/bash
PUSH_GATEWAY_NAME="pushgateway"

used_ram_bytes=$(awk '/MemTotal/ {total=$2} /MemFree/ {free=$2} /Buffers/ {buffers=$2} $1 ~ /^Cache/ {cached=$2} /SReclaimable/ {reclaim=$2} /Shmem:/ {shmem=$2} END {printf "%.0f", ((total - free) - (buffers + cached + reclaim - shmem))}' /proc/meminfo)
ram_total_bytes=$(awk '( $1 == "MemTotal:" ) { print $2 }' /proc/meminfo)
push_gateway_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $PUSH_GATEWAY_NAME.web.1)

cat <<EOF | curl --data-binary @- $push_gateway_ip:9091/metrics/job/memory_report/instance/fs_info
# TYPE ram_usage_bytes gauge
# HELP ram_usage_bytes used ram in bytes
ram_usage_bytes $used_ram_bytes
# TYPE ram_total_bytes gauge
# HELP ram_total_bytes installed ram in bytes
ram_total_bytes $ram_total_bytes
EOF
