#!/bin/bash
PUSH_GATEWAY_NAME="pushgateway"

ram_used_bytes=$(awk '/MemTotal/ {total=$2} /MemFree/ {free=$2} /Buffers/ {buffers=$2} $1 ~ /^Cache/ {cached=$2} /SReclaimable/ {reclaim=$2} /Shmem:/ {shmem=$2} END {printf "%.0f", ((total - free) - (buffers + cached + reclaim - shmem))}' /proc/meminfo)
ram_total_bytes=$(awk '( $1 == "MemTotal:" ) { print $2 }' /proc/meminfo)
swap_used_bytes=$(awk '/SwapTotal/ {total=$2} /SwapFree/ {free=$2} END {printf "%.0f", (total - free)}' /proc/meminfo)
swap_total_bytes=$(awk '( $1 == "SwapTotal:" ) { print $2 }' /proc/meminfo)
push_gateway_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $PUSH_GATEWAY_NAME.web.1)

cat <<EOF | curl --data-binary @- $push_gateway_ip:9091/metrics/job/memory_report/instance/fs_info
# TYPE ram_used_bytes gauge
# HELP ram_used_bytes used ram in bytes
ram_used_bytes $ram_used_bytes
# TYPE ram_total_bytes gauge
# HELP ram_total_bytes installed ram in bytes
ram_total_bytes $ram_total_bytes
# TYPE swap_used_bytes gauge
# HELP swap_used_bytes used swap memory in bytes
swap_used_bytes $swap_used_bytes
# TYPE swap_total_bytes gauge
# HELP swap_total_bytes used swap memory in bytes
swap_total_bytes $swap_total_bytes
EOF
