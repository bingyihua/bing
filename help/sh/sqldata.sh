#!/usr/bin/env bash
#获取50范围【1-50】的随机数 
# echo $((RANDOM%50+1)) 
a=('dds' 'aaa' 'sssss' 'errr')
#a=(`seq 10`)
let len=${#a[@]}-1
index1=$((RANDOM%$len+1)) 
index2=$((RANDOM%$len+1))
for i in {1..600000};
do
	echo "this is $i ge" ${a[$index1]}","${a[$index2]}";" >>data
done

