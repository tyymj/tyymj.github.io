#!/bin/bash
service cron stop
cat > /var/spool/cron/crontabs/pi << EOF
*/2 * * * * sh /data/projects/tyymj.github.io/update_ip.sh > /data/projects/tyymj.github.io/change.log 2>&1
EOF
service cron restart
