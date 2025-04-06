#!/bin/bash
set -e

if [ $(id -u) -ne 0 ]; then
    echo "Script must be run as root."
    exit
fi

source $1

install_path='/etc/systemd/system/'

for s in ${services[@]};
do
    cp ${source_path}${s} ${install_path}
    chown root ${install_path}${s}
    chgrp root ${install_path}${s}
    chmod 644 ${install_path}${s}
done

systemctl daemon-reload

for s in ${enable[@]};
do
    systemctl enable $s
done

for s in ${start[@]};
do
    systemctl start $s
done
