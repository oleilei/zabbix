#!/bin/bash

echo "1.设置zabbix账号授权运行netstat -nltp的权限"
echo "zabbix ALL=(root) NOPASSWD:/bin/netstat" > /etc/sudoers.d/zabbix
echo 'Defaults:zabbix   !requiretty'  >>  /etc/sudoers.d/zabbix
chmod 600  /etc/sudoers.d/zabbix

echo "2.将qiueer目录、redis.py复制到 /data/local/zabbix/monitor_scripts/redis目录，供参考："
wget https://github.com/oleilei/zabbix/archive/master.zip
unzip master
cd zabbix-master/Redis/
mkdir -p /data/local/zabbix/monitor_scripts/redis/
cp -R qiueer redis.py .redis.passwd /data/local/zabbix/monitor_scripts/redis/


echo "3.zabbix_agent.conf配置文件中需包含如下配置，注意脚本的位置"

# UnsafeUserParameters=0
sed -i 's/^# UnsafeUserParameters=0/UnsafeUserParameters=1/g' /data/local/zabbix/etc/zabbix_agentd.conf
sed -i 's/^UnsafeUserParameters=0/UnsafeUserParameters=1/g' /data/local/zabbix/etc/zabbix_agentd.conf
sed -i 's/^# Include=\/usr\/local\/etc\/zabbix_agentd.conf.d\/\*.conf/Include=\/data\/local\/zabbix\/etc\/zabbix_agentd.conf.d\/*.conf/g' /data/local/zabbix/etc/zabbix_agentd.conf

echo "
## qiueer redis-stat for discovery
UserParameter=redis.discovery.list, python /data/local/zabbix/monitor_scripts/redis/redis.py --list
UserParameter=redis.discovery[*],python /data/local/zabbix/monitor_scripts/redis/redis.py -p \$1 -k \$2
" > /data/local/zabbix/etc/zabbix_agentd.conf.d/userparameter.redis.conf

more /data/local/zabbix/etc/zabbix_agentd.conf.d/userparameter.redis.conf

chown -R zabbix.zabbix /data/local/zabbix
chmod -R +x /data/local/zabbix

echo "4.重启zabbix agent"
grep -v '^#' /data/local/zabbix/etc/zabbix_agentd.conf
killall zabbix_agentd
ps -ef|grep zabbix
sleep 1
/data/local/zabbix/sbin/zabbix_agentd
ps -ef|grep zabbix
tail -f /tmp/zabbix_agentd.log

echo "5.请在zabbix管理前端导入模板：Template App Redis Discovery.xml ..."