echo "盛年不重来，一日难再晨，及时当勉励，岁月不待人，少易学,老难成，一寸光阴不可轻"
echo "------何以解忧唯有单词-------"
awk -vN=5 -vC="`wc -l fanyi.txt`" 'BEGIN{srand();while(n<N){i=int(rand()*C+1);if(!(i in a)){a[i]++;n++}}}NR in a' fanyi.txt
echo "-------坚持弥补缺少----------"

#echo "今天星期$(date -d `date +%Y%m%d`  +%w),2019年猪年已过$(( ( $(date -d $(date +%Y%m%d)  +%s)  - $(date -d "20190101"  +%s) )/(24*60*60) ))天,距春节剩$(( ($(date -d "20190205"  +%s) - $(date -d $(date +%Y%m%d)  +%s))/(24*60*60) ))天 "
a=$(( $(date -d $(date +%Y%m%d)  +%s)/(24*60*60) - $(date -d "20190413"  +%s)/(24*60*60) ))

echo "$(( ($a - $a%7)/7 ))week ,$(($a%7))day"
cp ~/cuiyb/help.sh .help.sh
sed -i '/cui/d'  ~/.bash_history
sed -i '/my/d'  ~/.bash_history
sed -i '/vm/d'  ~/.bash_history
sed -i '/vb/d'  ~/.bash_history
