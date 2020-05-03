#!/bin/bash
rm 1dd qq 2 2>/dev/null
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
                        q[$i]=`awk '{if($2=='"$i"')print $3}'   <(echo $cmd|bash)`
        fi
        done
        aa=`for i in {1..61};do echo -n ${q[$i]}"|" ;done`
        echo $aa|sed 's/\(.*\)|\(.*\)/\1\2/' >> ~/551_file.txt
done
