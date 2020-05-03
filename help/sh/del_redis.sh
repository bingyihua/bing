#redis 删list
#!/bin/bash
if [ ! $1 ]; then
        echo "command fail!"
        echo "please use command: CleanRedis [FileName]"
        exit 0
fi
ADDRLIST=(192.168.117.243 192.168.117.243 192.168.117.243 192.168.117.244 192.168.117.244 192.168.117.244 192.168.117.245 192.168.117.245 192.168.117.245)
PORTLIST=(7000 7001 7002 7003 7004 7005 7006 7007 7008)
PWD=abc123
CLUSTER_FLAG='-c'
for i in `seq 0 $((${#ADDRLIST[*]}-1))`
do
        ADDR=${ADDRLIST[${i}]}
        PORT=${PORTLIST[${i}]}
        echo 'connection '${ADDR}':'${PORT}
        if [ -z $PWD ]; then
                DEL_LIST=`redis-cli -h $ADDR -p $PORT keys "$1*"`
        else
                DEL_LIST=`redis-cli -h $ADDR -p $PORT -a $PWD keys "$1*"`
        fi
        for DEL_ITEM in $DEL_LIST
        do
                if [ -z $PWD ]; then
                        redis-cli -c -h $ADDR -p $PORT DEL $DEL_ITEM
                else
                        redis-cli -c -h $ADDR -p $PORT -a $PWD DEL $DEL_ITEM

                fi
                echo -e "\033[31m delete \033[32m"$DEL_ITEM "\033[0m"
        done
done

#usr/local/redis-3.0.6/src/redis-server /usr/local/cluster/7000/redis.conf
#启动redis
#redis-cli -c -h 192.168.117.245 -p 7008 -a abc123
#进入cli
echo "LRANGE B1216006.451_VL_ERR  0 -1" | redis-cli -c -h 192.168.117.245 -p 7008 -a abc123  >key
#导出list值
#echo "rpush 075588888888 1||1||v0001||20180921145818||20991231235959||1||500||2" | redis-cli -c -h 192.168.117.245 -p 7008 -a abc123
