
#查看对应主机 内存cpu占比最高的进程前5个
echo "192.168.117.227 ps---------------------by rss,pmem,pcpu,vsize"
/home/mcbadm/cuiyb/ssh/bin/sshpass -p Mcb9cs#1227  ssh root@192.168.117.227 "ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print \$1 ,\$2,\$3,\$5,\$6,\$7}'";

echo "192.168.117.243 ps---------------------by rss,pmem,pcpu,vsize"
/home/mcbadm/cuiyb/ssh/bin/sshpass -p McbUnix_2017 ssh mcbadm@192.168.117.243 "ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print \$1 ,\$2,\$3,\$5,\$6,\$7}'";

echo "192.168.117.244 ps---------------------by rss,pmem,pcpu,vsize"
/home/mcbadm/cuiyb/ssh/bin/sshpass -p McbUnix_2017 ssh mcbadm@192.168.117.244 "ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print \$1 ,\$2,\$3,\$5,\$6,\$7}'";

echo "192.168.117.245 ps---------------------by rss,pmem,pcpu,vsize"
/home/mcbadm/cuiyb/ssh/bin/sshpass -p McbUnix_2017 ssh mcbadm@192.168.117.245 "ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print \$1 ,\$2,\$3,\$5,\$6,\$7}'";

echo "192.168.117.242 ps---------------------by rss,pmem,pcpu,vsize"

/home/mcbadm/cuiyb/ssh/bin/sshpass -p McbUnix_2017 ssh mcbadm@192.168.117.242 "ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print \$1 ,\$2,\$3,\$5,\$6,\$7}'"


echo "192.168.117.247 ps---------------------by rss,pmem,pcpu,vsize"
ps -eo rss,pmem,pcpu,vsize,args |  sort -k 1 -r -n |head -5|awk '{print $1 ,$2,$3,$5,$6,$7}'
