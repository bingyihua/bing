awk 'BEGIN {

do {
print x;
x+=1;
}
while(x<=10)
print  x +7
} ' <(seq 9)
 awk '{
    a[$1"\t"$2]=a[$1"\t"$2]?a[$1"\t"$2]" "$NF:$NF}
 END{
	for(i in a)
    	{
    		split(a[i],b," ");
     		t=asort(b,c);
     		for(j=1;j<=t;j++)
     			{
        			if(c[j+1]-c[j]==1)
                    	{s=s" "c[j]}
                    else
                    	{
                        	x=split(s" "c[j],d," ");
                            if(x==0)
                            print i" "c[j]" "c[j];
                            else
                            print i " "d[1]" "d[x];s=""
                         }
                      }
                    }
        }'     1.txt

# awk -vv="a4" -vRS="[^\n]+(){[^{}]+}" 'RT~"^"v{ss=RT}END{if(ss){print ss}else{print "NO FIND"}}' 3.sh

a=(`grep -oP '\b(?<!\.)\w+\.\w+(?!\.)\b'  1.sh`)

echo ${a[1]}
