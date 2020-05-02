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

#

prov=898
counter=0
while read line;
do
	if test ${counter} -eq 20;then
		echo "waiting for sleeping 60s..."
		sleep 60s && counter=0
	fi
	echo " cp /home/testB/301908/${line} /opt/data/567"
	cp /home/testB/301908/${line} /opt/data/567
	sleep 10s
	(( counter += 1 ))
done < <(ls 201908 | awk '{if ((substr($0,4,5)+0) > 5084 )print}')



