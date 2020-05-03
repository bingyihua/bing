#!/usr/bin/env bash
#大数量话单需要分批串行在测试环境跑，不然会处理失败
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
