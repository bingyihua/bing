# a=[]
# for i in {1..10}
# do
#     echo a[$i]=a[$((i-1)] + "ss"
# done
#!/bin/bash
name[0]=""
for ((i=1;i<13;i++))
do
name[$i]=${name[$i-1]}""
done
rm 1
touch 1
for ((i=1;i<=15;i++))

do
echo ${name[-1]}>>1
done
# cat  -A 1

# echo "0001|20081223efskjfdj|EREADFASDLKJCV" |awk -F '|'  'BEGIN{ OFS="|" } {gsub(/[0-9]+/,"",$2);print $0}'
# echo "0001|20081223efskjfdj|" |awk -F '|'  'BEGIN{ OFS="|" } {gsub("","2",$3);print $0}'

name[$i]=${name[$i-1]}""
 # awk -F ''  'BEGIN{ OFS="" ;i=1}{gsub($2,i++,$2);gsub($3,11+i,$3);print $0}' 1
# awk -F ''  'BEGIN{ OFS="" ;i=1;j=3;m=0}{m++}{if(i<7){gsub($2,i++,$2);gsub($3,m,$3)}else if(i>6){gsub($2,j++,$2);gsub($3,m,$3)}}{print $0.m}' 1
 # awk 'function sum(n){c=$0;for(i=0;++i<n;){if(getline l)num+=l}print num+c;num=0}{sum(++n)}'
# awk 'BEGIN{s=0;m=100;while(1){print s=s+n;n=s-n;if(!s)++s;if(s>m)exit}}'
# awk 'BEGIN{s=0;m=100;while(1){print s;s=s+n;n=s-n;if(!s)++s;if(s>m)exit}}'
# awk -F ''  'BEGIN{ OFS="" ;i=1;j=3;m=0}{m++}{if(i<7){gsub($1,103,$1);gsub($2,i++,$2);gsub($3,m,$3)}else if(i>6){gsub($1,103,$1);gsub($2,j++,$2);gsub($3,m,$3)}}{print $0}' 1

awk -F ''  'BEGIN{ OFS="" ;i=1;j=3;}\
{if(i<=12){gsub($1,103,$1);gsub($2,"",$2);gsub($3,21005,$3);\
gsub($6,"20180301095757",$6);gsub($11,i++,$11);gsub($12, int(rand()*(999-100+1))".50",$12)}\
 else if(i>12){gsub($1,103,$1);gsub($2,"",$2);gsub($3,21005,$3);\
gsub($6,"20180301095757",$6);gsub($11,j++,$11);gsub($12, int(rand()*(999-100+1))".50",$12)} }{print  $0}' 1  >mb_body
# cat  -A 2
# awk -F ''  'BEGIN{ OFS="" ;i=1;j=3;m=0}{m++}{if(i<7){gsub($2,i++,$2);gsub($3,m,$3)}else if(i>6){gsub($2,j++,$2);gsub($3,m,$3)}}{print $2}' 1|\
# awk '{a[$1]++}END{for(i in a){print a[i] }}'
awk -F ""  '{a[$11]+= $12}END{len=asorti(a,b);for(i=1;i<=len; i++)t=t?t""" "a[i]:""a[i];print t}' mb_body | xargs printf "%.2f " >33
# sed  '1d;$p' IAP_MBList_20180527_003.txt |awk -F"^_"  '{a[$11]+= $12}END{len=asorti(a,b);for(i=1;i<=len; i++)t=t?t" "i" "a[i]:i" "a[i];print t}'
# sed  '1d;$p' IAP_MBList_20180527_003.txt |awk -F"^_"  '{a[$11]+= $12}END{len=asorti(a,b);for(i=1;i<=len; i++)t=t?t" "i" "a[i]:i" "a[i];print t}' > 33
# awk -F ''  'BEGIN{ OFS="" ;i=1;j=3;m=0}{m++}{if(i<7){gsub($2,i++,$2);gsub($3,m,$3)}else if(i>6){gsub($2,j++,$2);gsub($3,m,$3)}}{print $2}' 2
awk  -F ""  '{a[$11]++} END{for (i in a){print a[i] }}' mb_body |tr "\n" " " >44
# awk '{a[$3]++}END{for(i in a){print i,a[i] | "sort -k 1"}}' 2
# |tr "\n" " "
# echo "100 200 300 400 500 600 700 800 900 1000">33
# cat 44
# printf "%s %s %s\n" a b c d e f g h i j

awk 'BEGIN{if(NR>0) a[NR]=0}{if(NR>0) for(i=1; i<=NF; i++) a[NR]+=$i}END{for(j in a) print a[j] }' 44 >max


# echo "100 200 300 400 500 600 700 800 900 1000" |awk '{print '"`cat max`"', $0 }'


awk 'ARGIND==1{for(i=1;i<=NF;i++)a[i]=$i}ARGIND==2{for(i=1;i<=NF;i++)b[i]=$i}END{for(i=1;i<=NF;i++)printf("%s %s ",a[i],b[i])}'  44 33 | awk    '{print "'`cat max`'"  ,$0 }' |sed 's/.$//'|sed 's/ //g' >mb_totile
awk 'BEGIN {print "'`cat mb_totile`'"}{print $0}' mb_body | cat -A
# echo "100 200 300 400 500 600 700 800 900 1000" | awk   -F  " "   '{ OFS="|" }{print $0}'
# echo '12|qwq|223|qqq|33333' >3
# sed -ri 's/[^|]*|/www/3' 3
# cat 3