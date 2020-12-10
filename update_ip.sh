#/bin/bash
# crontab -e
# */10 * * * * sh /data/scripts/update_ip.sh > /data/scripts/task.log 2>&1
now=$(TZ='Asia/Shanghai' date +"%Y-%m-%d %H:%M:%S")
home=$(cd `dirname $0`; pwd)
cd $home

# fetch and compare current ip
old_ip=$(cat ip)
current_ip=$(curl -s 'http://ip-api.com/line' | tail -n 1)
echo "$now old_ip=$old_ip, current_ip=$current_ip"
if [ "$current_ip" = "$old_ip" ];then
  echo "$now ip no change"
  return
fi

# update repo ip
echo "$now ip need update"
echo $current_ip > ip
git add ip
git commit -m "update ip from $old_ip to $current_ip"
git push
