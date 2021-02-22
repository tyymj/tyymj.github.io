#!/bin/bash
service cron stop
sudo cat > /var/spool/cron/crontabs/pi << EOF
*/10 * * * * sh /data/work/tyymj.github.io/update_ip.sh > /data/work/tyymj.github.io/change.log 2>&1
EOF
service cron restart
