#!/bin/bash
cat > /var/spool/cron/crontabs/root << EOF
# */10 * * * * sh /data/work/tyymj.github.io/update_ip.sh > /data/work/tyymj.github.io/change.log 2>&1
EOF
service cron restart
