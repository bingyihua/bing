#select * from user; 
awk 1 user;
#select * from consumer where cost > 100;
awk '{if($2>100 && $2>108) print $1,$2}' consumer
#
awk '/100/,/115/' consumer
awk '/100/ {count++;}END {print "tom was found "count" times"}' consumer
#统计指定关键词出现的次数
#select distinct(date) from consumer;
awk '!a[$3]++{print $3}' consumer
#去重计数
awk   '{a[$1]++}END{for (j in a) print a[j],j}' consumer
#select distinct(*) from consumer;
awk '!a[$0]++' consumer
#select id from user order by id;
awk '{a[$1]}END{asorti(a);for(i=1;i<=length(a);i++){print a[i]}}' user
#select * from consumer limit 2;
awk 'NR<=2' consumer
awk 'NR>2{exit}1' consumer # performance is better
#select id, count(1), sum(cost) from consumer group by id having count(1) > 2;
awk '{a[$1]=a[$1]==""?$2:a[$1]","$2}END{for(i in a){c=split(a[i],b,",");if(c>2){sum=0;for(j in b){sum+=b[j]};print i"\t"c"\t"sum}}}' consumer
#默认a[$1]的值是空所以要用三目，三目是if else的缩略版，把第一列相同的值 通过逗号合并为一行，end取最后一个动作，a[$1]相当于第一列的值，再通过切片分割获取元素个数，c是切片的返回值为数组的个数，循环中的i相当于$1,a[$1]对应列的当前动作的列值
#select name.  from user where name like 'wang%';
awk '$2 ~/^wang/{print $2}' user
#select addr from user where addr like '%bei';
awk '/.*bei$/{print $3}' user
#select addr from user where addr like '%bei%';
awk '$3 ~/bei/{print $3}' user
#select a.* , b.* from user a inner join consumer b  on a.id = b.id and b.id = 2;
awk 'ARGIND==1{a[$1]=$0;next}{if(($1 in a)&&$1==2){print a[$1]"\t"$2"\t"$3}}' user consumer
cat data|awk '{sum+=$1} END {print "Sum = ", sum}'
cat data|awk '{sum+=$1} END {print "Average = ", sum/NR}'
cat data|awk 'BEGIN {max = 0} {if ($1>max) max=$1 } END {print "Max=", max}'
awk 'BEGIN {min = 1999999} {if ($1<min) min=$1} END {print "Min=", min}'
#awk BEGIN{}  是在文件开始扫描前进行的操作  END {} 是扫描结束后 进行的操作  ;一般的操作都是需要在BEGIN 设置一个初始的量
awk 'BEGIN{print "地点\t";total=0;} {print $3;total = total+NR} END{printf "行数总计: %2d\n", total}' awk_test.txt
#指定列相同值的另一列值按空格合并为一行作为新的一列值
awk '{a[$2]=a[$2]" "$1} END {for(i in a) print i"\t"a[i]}' input_file
