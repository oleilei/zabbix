#!/bin/bash
REDISCLI="/usr/local/bin/redis-cli"
HOST="127.0.0.1"
PORT=6180
PASS="li*9#&19Fe"

if [[ $# == 1 ]];then
case $1 in
role)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "role" | awk -F':' '{print $2}'`
echo $result
;;
master_host)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "master_host" | awk -F':' '{print $2}'`
result=${result:=$HOST}
echo $result
;;
master_port)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "master_port" | awk -F':' '{print $2}'`
result=${result:=$PORT}
echo $result
;;
slave_repl_offset)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "slave_repl_offset" | awk -F':' '{print $2}'`
echo $result
;;
master_repl_offset)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "master_repl_offset" | awk -F':' '{print $2}'`
echo $result
;;
slave_read_only)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "slave_read_only" | awk -F':' '{print $2}'`
echo $result
;;
connected_slaves)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "connected_slaves" | awk -F':' '{print $2}'`
echo $result
;;
slave_priority)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "slave_priority" | awk -F':' '{print $2}'`
echo $result
;;

rdb_last_save_time)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "rdb_last_save_time" | awk -F':' '{print $2}'`
echo $result
;;

version)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info server 2>/dev/null | grep -w "redis_version" | awk -F':' '{print $2}'`
echo $result
;;
uptime)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info server 2>/dev/null | grep -w "uptime_in_seconds" | awk -F':' '{print $2}'`
echo $result
;;
connected_clients)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info clients 2>/dev/null | grep -w "connected_clients" | awk -F':' '{print $2}'`
echo $result
;;
blocked_clients)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info clients 2>/dev/null | grep -w "blocked_clients" | awk -F':' '{print $2}'`
echo $result
;;
used_memory)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info memory 2>/dev/null | grep -w "used_memory" | awk -F':' '{print $2}'`
echo $result
;;
used_memory_rss)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info memory 2>/dev/null | grep -w "used_memory_rss" | awk -F':' '{print $2}'`
echo $result
;;
used_memory_peak)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info memory 2>/dev/null | grep -w "used_memory_peak" | awk -F':' '{print $2}'`
echo $result
;;
used_memory_lua)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info memory 2>/dev/null | grep -w "used_memory_lua" | awk -F':' '{print $2}'`
echo $result
;;
used_cpu_sys)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info cpu 2>/dev/null | grep -w "used_cpu_sys" | awk -F':' '{print $2}'`
echo $result
;;
used_cpu_user)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info cpu 2>/dev/null | grep -w "used_cpu_user" | awk -F':' '{print $2}'`
echo $result
;;
used_cpu_sys_children)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info cpu 2>/dev/null | grep -w "used_cpu_sys_children" | awk -F':' '{print $2}'`
echo $result
;;
used_cpu_user_children)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info cpu 2>/dev/null | grep -w "used_cpu_user_children" | awk -F':' '{print $2}'`
echo $result
;;
rdb_last_bgsave_status)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info Persistence 2>/dev/null | grep -w "rdb_last_bgsave_status" | awk -F':' '{print $2}' | grep -c ok`
echo $result
;;
aof_last_bgrewrite_status)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info Persistence 2>/dev/null | grep -w "aof_last_bgrewrite_status" | awk -F':' '{print $2}' | grep -c ok`
echo $result
;;
aof_last_write_status)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info Persistence 2>/dev/null | grep -w "aof_last_write_status" | awk -F':' '{print $2}' | grep -c ok`
echo $result
;;
*)
echo -e "\033[33mUsage: $0 {connected_clients|blocked_clients|used_memory|used_memory_rss|used_memory_peak|used_memory_lua|used_cpu_sys|used_cpu_user|used_cpu_sys_children|used_cpu_user_children|rdb_last_bgsave_status|aof_last_bgrewrite_status|aof_last_write_status}\033[0m"
;;
esac
elif [[ $# == 2 ]];then
case $2 in
keys)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "$1" | grep -w "keys" | awk -F'=|,' '{print $2}'`
echo $result
;;
expires)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "$1" | grep -w "keys" | awk -F'=|,' '{print $4}'`
echo $result
;;
avg_ttl)
result=`$REDISCLI -h $HOST -a $PASS -p $PORT info 2>/dev/null | grep -w "$1" | grep -w "avg_ttl" | awk -F'=|,' '{print $6}'`
echo $result
;;
*)
echo -e "\033[33mUsage: $0 {db0 keys|db0 expires|db0 avg_ttl}\033[0m" 
;;
esac
fi
