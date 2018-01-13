#!/bin/bash

# if this script is called, the updater <= V27 is running and the directory structure has to be refactored

rm -rf /var/local/rocon-g1.tmp
mv /var/local/rocon-g1/connector /var/local/rocon-g1.tmp
cd /var/local/rocon-g1.tmp
/usr/local/bin/node migrate.js

rm -rf /var/local/rocon-g1
mv /var/local/rocon-g1.tmp /var/local/rocon-g1

echo "[Unit]
Description=Rocon Updater (one-shot rocon updater on startup)
Requires=network.target
After=rocon.service
[Service]
Type=oneshot
WorkingDirectory=/var/local/rocon-g1/updater
ExecStart=/var/local/rocon-g1/updater/run.sh
StandardOutput=syslog
SyslogIdentifier=rocon.updater
User=root
Group=root
RemainAfterExit=yes
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/rocon-updater.service

/bin/systemctl enable rocon-updater.service

/sbin/reboot