#/bin/bash
# crontab -e
# */10 * * * * sh /data/projects/tyymj.github.io/update_ip.sh > /data/projects/tyymj.github.io/change.log 2>&1
# */10 * * * * sh /data/projects/tyymj.github.io/update_ip.sh > /dev/null 2>&1

if [ ! -f /usr/bin/curl ]; then
  echo "not found curl, install curl now."
  sudo apt-get install -y curl
fi

if [ ! -f /usr/bin/jq ]; then
  echo "not found jq, install jq now."
  sudo apt-get install -y jq
fi

if [ ! -f /usr/bin/git ]; then
  echo "not found git, install git now."
  sudo apt-get install -y git
fi

now=$(TZ='Asia/Shanghai' date +"%Y-%m-%d %H:%M:%S")
home=$(cd `dirname $0`; pwd)
cd $home

get_ip() {
    #ip=$(curl -s "https://api.ipify.org/")
    #ip=$(curl -sL "https://www.ip.cn/api/index?ip=&type=0" | jq -c ".ip" | tr -d '"')
    #ip=$(curl -sL "https://api64.ipify.org?format=json" | jq ".ip" | tr -d '"')
    ip=$(curl "https://ipinfo.io/ip")
    echo "$ip"
}

# fetch and compare current ip
git pull
old_ip=$(cat ip)
#current_ip=$(curl -s 'http://ip-api.com/line' | tail -n 1)

current_ip=$(get_ip)
echo "current_ip: $current_ip"

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
git push -f
