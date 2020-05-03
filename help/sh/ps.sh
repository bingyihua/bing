#!/bin/bash
for i in 61 62 63 64 65 74;
do
	ssh -o StrictHostKeyChecking=no  192.168.158.1$i "ps -ef|grep SNAPSHOT.jar" |egrep -v 'grep|save2redis|Author'|awk '{print $NF}' 
done
