/usr/local/redis-3.0.6/src/redis-server /usr/local/cluster/7000/redis.conf
#启动redis
redis-cli -c -h 192.168.117.245 -p 7008 -a abc123
#
echo "LRANGE B1216006.451_VL_ERR  0 -1" | redis-cli -c -h 192.168.117.245 -p 7008 -a abc123  >key
#导出list值
echo "rpush 075588888888 1||1||v0001||20180921145818||20991231235959||1||500||2" | redis-cli -c -h 192.168.117.245 -p 7008 -a abc123

#!/bin/bash
rm 1 qq 2 2>/dev/null
rm ~/551_file.txt 2>/dev/null
echo "exp hbase to data by args..."
echo "import org.apache.hadoop.hbase.filter.CompareFilter;import org.apache.hadoop.hbase.filter.SubstringComparator;import org.apache.hadoop.hbase.filter.RowFilter;scan 'vlthb:PRE_MERGE_CDR_VLT_HM_201907_551', {FILTER => RowFilter.new(CompareFilter::CompareOp.valueOf('EQUAL'), SubstringComparator.new('VLT_MERGE_20190714_551_10000'))}"|hbase shell 2>/dev/null  >1
awk  '{print $1}' 1 |grep VLT_MERGE|awk '{a[$1]++}END{for(i in a){print i}}' >2
echo "start insert data,total count is $(wc -l 2) ....."
a=0
for j in `cat 2`
do
	a=$(($a+1))
	echo "insert $a  record... "
	q=[]
	cmd="grep -w $j 1 |awk '{\$2=substr(\$2,13,4);\$4=substr(\$4,7,200)}{print \$1,\$2,\$4}'|sed 's/,//g'"
	for i in {1..61};
	do 
		if [[ `echo $cmd|bash|awk '{print $2}'|grep -w $i` ]]; then
			q[$i]=`awk '{if($2=='"$i"')print $3}'	<(echo $cmd|bash)`
	fi
	done
	aa=`for i in {1..61};do echo -n ${q[$i]}"|" ;done`
	echo $aa|sed 's/\(.*\)|\(.*\)/\1\2/' >> ~/551_file.txt
done

b=("aaa" "bbb" "ccc"); t=${b[@]};awk -vk="$t" 'BEGIN{d=split(k,a," ")}{for(i=1;i<=NF;i++) {if($i~/[a-z]+/) print NR,a[i];}}' dd
set -- ${b[@]};line=1;while read x y z other;do  [[ "${x}" =~ ^[[:alpha:]]+$ ]] &&  echo "${line} $1";[[ "${y}" =~ ^[[:alpha:]]+$ ]] &&  echo "${line} $2";[[ "${z}" =~ ^[[:alpha:]]+$ ]] &&  echo "${line} $3";(( line+=1 ));done < dd

awk -vk="$t" 'BEGIN{d=split(k,a," ")}{for(i=1;i<=NF;i++) {if($i~/[a-z]+/) print NR,a[i];}}' file
perl -anE '@b=("aaa","bbb","ccc");$F[$_]=~/\D/&&say"$. $b[$_]"for 0..$#F' dd
awk -vx='aa' -vy='bb' -vz='cc' '{for(i=1;i<=NF;i++)a[$i]=i}NR>1{print $a[x],$a[y],$a[z]}' txt

awk -vx='aa'   '{for(i=1;i<=NF;i++)a[$i]=i}NR>1 && $a[x]>44{print $a[x]}' txt


echo "006 7" |awk  '{if( (($1+0)%6)>0) { $3=(($1+0)-($1+0)%6)+6}else{ $3=($1+0)} {if($2!=$3) print "错误" ;else print "正确"}}'

awk '{if ($1==1) print "A" else if ($1==2) print "B" else print "C"}'
echo "006 6 7"|awk '{if($2!=$3)print $0,"ok"} '
echo "006 6" |awk  '{if( (($1+0)%6)>0) { $3=(($1+0)-($1+0)%6)+6}else{ $3=($1+0)} print $1,$2,$3 }'
awk '{for(i=1;i<=NF;i++) if($i ~ /^[0-9]+$/){ print $i;}}'  dd
awk '{for(i=1;i<=NF;i++) if($i !~ /^[0-9]+$/){ print $i;}}'  dd
awk '{for(i=1;i<=NF;i++) if($i !~ /^[0-9]+$/){ print NR,i;}}'  dd
awk -F "|"   '$5 > strftime("%Y%m%d%H%M%S"){ print $0}' cc
awk '$1!=1{print NR}'

awk '{$1="";print $0}' ziduan_tmp

echo "123 a" |awk '{if($1 ~ /^[0-9]+$/  || $1 = "") print NR }'

awk -F "|" '{if($2 !~ /^[0-9]+$/  && $2 != "") print NR }' cc

awk -F "|" -vOFS="|"  '$6=$6+0 ,$15=$15+0' cc

perl -i -F'..\|\|.*?\|\K' -lane '$F[1]=~s#^22583[0-8]##;print@F' test
awk 'BEGIN{now=strftime("%Y%m%d%H%M%S"); print now}'

awk -F "|" -vOFS="|"  'gsub(/^12583[0-8]|0086|86；|0|^12583[0-8][0086|86|0]/,"",$4)' bb >cc;cat cc

awk -F "|"  'gsub(/^2583[0-8]/,"",$4)' cc

awk -vFIELDWIDTHS="2 15 15 24 14 6 10 4 10 3 4 1 1 1 6 1 20 15 6"   -vOFS="|"  'NF=NF'   <( awk '{line[NR]=$0} END {for(i=2 ;i<=NR-1;i++) print line[i]}' B1216002.100.20151216001723 |sed  's/^M$/\n/g') >bb

awk -F"|" '{if($62==3 && $9==1) print$12}'   201908_100_cdr.csv 


netstat -apn | grep 8080
netstat -apn | grep ssh
#查看ssh端口

ps -ef|grep java
lsof -i:8080 
#查看占用端口进程的PID：


 
