echo "ʢ�겻������һ�����ٳ�����ʱ�����������²����ˣ�����ѧ,���ѳɣ�һ�����������"
echo "------���Խ���Ψ�е���-------"
awk -vN=5 -vC="`wc -l fanyi.txt`" 'BEGIN{srand();while(n<N){i=int(rand()*C+1);if(!(i in a)){a[i]++;n++}}}NR in a' fanyi.txt
echo "-------����ֲ�ȱ��----------"

#echo "��������$(date -d `date +%Y%m%d`  +%w),2019�������ѹ�$(( ( $(date -d $(date +%Y%m%d)  +%s)  - $(date -d "20190101"  +%s) )/(24*60*60) ))��,�ഺ��ʣ$(( ($(date -d "20190205"  +%s) - $(date -d $(date +%Y%m%d)  +%s))/(24*60*60) ))�� "
a=$(( $(date -d $(date +%Y%m%d)  +%s)/(24*60*60) - $(date -d "20190413"  +%s)/(24*60*60) ))

echo "$(( ($a - $a%7)/7 ))week ,$(($a%7))day"
cp ~/cuiyb/help.sh .help.sh
sed -i '/cui/d'  ~/.bash_history
sed -i '/my/d'  ~/.bash_history
sed -i '/vm/d'  ~/.bash_history
sed -i '/vb/d'  ~/.bash_history
