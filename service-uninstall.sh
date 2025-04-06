#!/bin/bash
set -e

if [ $(id -u) -ne 0 ]; then
    echo "Script must be run as root."
    exit
fi

source $1

for s in ${services[@]};
do
    systemctl stop ${s}
    systemctl disable ${s}
    rm /etc/systemd/system/${s}
done

systemctl daemon-reload
