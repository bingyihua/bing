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

echo "1 2 3 44 55 66" |awk '{for(i=1;i<=NF;i++)if ($i==44){print FNR ,i}}'
echo "1 2 3 44 55 66" | awk '{if ($1 > 100) print $1 "bad" ; else print "ok"}' test
echo "1 2 3 4 5" | awk '{for(i=1;i<=NF;i++) sum+=$i} END{print "sum="sum}'
awk '$1==22{print FNR}'
echo "10 23 11
22 33a ww
33 eeq qqq"| awk 'BEGIN {sum=0}{if($1 >10){sum+=$1}}END{print sum}'
awk  'NR==2 {print $2 }' 2
a='Susan'
awk -F ";" '{for(i=1;i<=NF;i++)if ($i=='"$a"'){print FNR ,i}}' 2

awk    '{for(i=1;i<=NF;i++)if ($i=='250'){print FNR ,i}}' 2
# awk -F -v str="Susan" '{v="";for (i=1;i<=NF;i++)  if ($i==str) v=v?"" :i;if (v) print str":\t"NR"Line"v"Column"}'  2

 echo 'EGFR_1_p chr7 55087057
EGFR_1_p chr7 55087055
EGFR_1_p chr7 55087058
ERBB2_1 chr17 37856493
ERBB2_1 chr17 37856494
ERBB2_1 chr17 37856495
ERBB2_1 chr17 37856496
ERBB2_1 chr17 37856597
ERBB2_1 chr17 37856598
ERBB2_1 chr17 37856599
ERBB2_2 chr17 37866500
ERBB2_2 chr17 37866501' |awk '{a[T=$1 FS $2][$3];if(!b[T]++)N++;c[N]=T}END{for(i=1;i<=N;i++)
{{PROCINFO ["sorted_in"]="@ind_num_asc";x=0;l=length(a[c[i]]);n=0;for(k in a[c[i]]){n++;if(k!=x+1){if(x)print FS x;printf c[i] FS k};x=k;if(n==l)print FS k}}}}'
 
 awk '/localhost/{print}' /etc/hosts
awk '/^fe/{print}' /etc/hosts
awk '/ab$/{print}' /etc/hosts
awk '/\$25.00/{print}' deals.txt
awk '/[0-9]/{print}' /etc/hosts 
awk '/[Kk]T/{print}' /etc/hosts 
#去重计数
awk   '{a[$1]++}END{for (j in a) print a[j],j}' consumer
