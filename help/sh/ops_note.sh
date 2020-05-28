[三目]
shell
                                 
[jinkens]
jinkens选择shell执行window命令(git bash已安装)无法找到命令的原因是没有添加本地用户导致的
services.msc打开找到jinkens服务添加本地用户重启即可解决问题
window docker 宿主机虚拟机的用户名docker 密码tcuser
mount.vboxsf Users /home  挂载共享
umount -f /home    取消共享

[py_regular]
re.subn('b([^\d])', lambda y: 'B'+y[1] , "HBh*b*b1*b2*t1*t2")[0]
y是b([^\d])的小括号的匹配值*
re.subn('正则表达式','替换的字符','要替换的字符串') #subn开启正则
re.sub('x','a','xxxbbb') #result 'aaabbb' 

[appuim]
###appuim视频教程##https://www.51zxw.net/list.aspx?cid=670#!fenye=2
appuim desktop版本为1.9.1尽量不要用最新容易报错
进入E:\Users\cui\AppData\Local\Android\android-sdk\build-tools\28.0.3E:\Users\cui\AppData\Local\Android\android-sdk\build-tools\28.0.3
执行aapt dump badging D:\test\xxx.apk
可以找找到指定app的appPackage和appActivity信息
"automationName" : "appium",  #默认为appium，还可以为Uiautomator2
'platformName': 'Android', 	  #选择平台
'platformVersion': '8.0.0',   #系统版本好
'deviceName': 'ZL522CW6NH',   #adb devices -l 可以查看
'newCommandTimeout': 240,	  #默认超时时间单位秒
"udid": "ZL522CW6NH",
"appActivity": "com.zrar.qghlwpt.StartActivity",
"appPackage": "com.zrar.qghlwpt",
"noReSet": True
"autoAcceptAlerts": true  	 # 默认选择接受弹窗的条款

adb shell pm list package    #语句可以查看以列表的方式显示所有的包名
adb shell pm list package -s #如何查看连接手机的系统应用
adb shell pm list package -3 #查看手机的第三方软件
adb shell pm list package -f #显示安装软件的路径
adb install 软件的绝对位置
adb uninstall 包名
adb shell dumpsys package com.zrar.qghlwpt    #获取Activity
weditor的安装和使用python -m weditor
[Grab_bag]
1、Burpsuite功能多，改参测压都可以
2、Fiddler一般就是电脑连网页手机用(一般用在抓app包数据，比较常用)
3、WireShark内网抓包，耗资源
#########Fiddler抓包2-只抓APP的请求
1.电脑上已装fiddler
2.手机和电脑在同一局域网
1.fiddler>Tools>Fiddler Options>Connections 勾选Allow remote computers to connect。
2.记住这里的端口号：8888，后面会用到。
#https://www.cnblogs.com/yoyoketang/p/6582437.html
http analysis 可以使用更详细的过滤规则

Packet Capture apk 手机端
抓http协议层的报文，一般用fiddler和burpsuite。看底层网络报文用wireshark好，能看见syn ack和完整的TCP报文，着重于协议分析
tcpdump
[sql]
Select dt,city,count(userid),count(distinct userid),sum(amount) 
 from recharge_record 
  where dt>='20181111' and city in ("上海","北京","成都","杭州") 
   group by dt,city
    having count(distinct userid)>100 and sum(amount) >1000
[mq]
set path=%path%;E:\Program Files\RabbitMQ Server\rabbitmq_server-3.8.3\sbin
添加环境变量
# rabbitmq-plugins enable rabbitmq_management
开启浏览器访问http://localhost:15672
默认userName:guest    password:guest
[cut]
Cut -c1 /etc/passwd 提取第一个字符
Cut -c1-5 /etc/passwd 提取1到第5个字符
Cut -c1,5 /etc/passwd 提取第1个和第5个字符
Cut -d: -f1-5 /etc/passwd 以:为分隔符提取1到第5个域
[ops_cmd]
###########################################
清理缓存的命令　
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches
uname1 2>/dev/null ;uname 2>/dev/null 
//错误的命令不输出，只输出对的命令

【用户权限】
gre                        p developers /etc/group	先确认一下是否存在 developers 这个用户组，在命令行输入：
groupadd developers	如果看不到任何输出，那么就需要先创建这个用户组了，使用 groupadd 命令
useradd -G developers cnzhx	创建用户 cnzhx 并将其加入到 developers 用户组
passwd cnzhx	为用户 cnzhx 设置密码
id cnzhx	为确保已经将该用户正确的添加到 developers 用户组中，可以查看该用户的属性
usermod -a -G apache cnzhx	将一个已有用户 cnzhx 增加到一个已有用户组 apache 中
-a 代表 append
groupadd test //新建test工作组	
groupadd damon	新建用户组damon
groupdel damon 	删除用户组damon

ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.56.101	把当前用户都秘钥传到指定用户ip到机器上，实现指定ip到免密登录

sshpass -p 'password' scp -o StrictHostKeyChecking=no  mem.sh amos@$host:/tmp/
sshpass -p 'password' ssh  -o StrictHostKeyChecking=no  amos@$host "sh /tmp/mem.sh"

netstat -apn | grep 8080
netstat -apn | grep ssh
#查看ssh端口
ps -ef|grep java
lsof -i:8080
#查看占用端口进程的PID

#把脚本设置为开机服务
sudo vim /etc/systemd/system/hello.service
 [Unit]
Description = hello daemon
 [Service]
ExecStart = /opt/hello.sh
Restart = always
Type = simple
 [Install]
WantedBy = multi-user.target

sudo systemctl list-unit-files --type=service | grep hello
# 开机自启动on
$ sudo systemctl enable hello
# 单次启动
$ sudo systemctl start hello
【openstack】
    （1）Nova - 计算服务
    （2）Swift - 存储服务
    （3）Glance - 镜像服务
    （4）Keystone - 认证服务
    （5）Horizon - UI服务
   


【查询日志】着闹ctl
cat head tail grep sed awk logcat等都可以 
journalctl -b #查看本次启动的所有日志也可以使用
journalctl -k #查看内核日志
journalctl --since="2018-09-21 10:21:00" #查看指定区间日志
journalctl --since="2018-09-21 10:21:00" --until="2018-09-21 10:22:00" 查看时间段日志
journalctl -u kubelet.service #按服务筛选
journalctl -p 5 -u kubelet
#操作系统提供了从0 (emerg) 到 7 (debug) 一共7个级别的日志，可以配合-p参数分别查看对应级别的日志。
    0: emerg
    1: alert
    2: crit
    3: err
    4: warning
    5: notice
    6: info
    7: debug
【#防护墙设置】
SELinux状态及关闭SELinux 
、/usr/sbin/sestatus -v
2、getenforce 
1、临时关闭（不用重启机器）：
setenforce 0 ##setenforce 1 设置SELinux 成为enforcing模式
2、修改配置文件需要重启机器：
修改/etc/selinux/config 文件
将SELINUX=enforcing改为SELINUX=disabled
重启机器即可

【k8s和docker】
docker stats --no-stream 
# --no-stream 选项只输出当前的状态 监控docker的cpu和内存百分比
docker stats --no-stream --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
#格式化输出
uptime 查看load值
top 查看cpu内存
ctop 就像 linux 的 top 命令一样，top 用来查看进程的实时状态，而 ctop 用来查看系统中各个容器的实时状态
CPU的测量单位是cpus，允许分数值。你可以使用前缀m来表示mili（千分之一）。例如100mcpu就是100 milicpu，等价于0.1CPU
kubectl top nodes node1 -n irm-server 
查看具体某一个node cpu 内存情况
kubectl top pod test-huishi-server-6f875487d7-9rzpd -n irm-server


ps -ef|grep xx
ps -aux 查看内存cpu资源
  
ps看到的是命令执行瞬间的进程信息,而top可以持续的监视
ps只是查看进程,而top还可以监视系统性能,如平均负载,cpu和内存的消耗
另外top还可以操作进程,如改变优先级(命令r)和关闭进程(命令k)
df -h 查看磁盘
free -m查看内存
du查看文档大小

find . -type f  -name '*.sh'    |xargs -i cp {} ~/sh/
#复制和find组合
ls | grep -P '[^!-~]' | xargs -i cp {} ~/sh/
#赋值包含汉字的文件名


docker tag docker.io/mysql:latest mysql:v1
#把镜像名docker.io/mysql 和标签名latest 改为mysql:v1
#如果docker images 之前的标签名还是存在，但还是只有一个镜像，可以看imageid 一样的，
docker rmi docker.io/mysql：latest
docker ps 查看运行的容器，docker images 查看当前镜像
kubectl get pod --all-namespaces -o wide查看所有pod的信息
kubectl get pod -n kube-system
kubectl delete deployment yrm --force --grace-period=0 删除一个部署
docker search XXX 查找docker源
docker pull
docker cp jdk1.8.0_91  1218a5d5022d:/usr/local
docker exec -it 194a22f33b1a /bin/sh tty登录到容器
kubectl edit deployment tiller-deploy -n kube-system 修改某应用部署的配置
kubectl logs -f coredns-5c98db65d4-mp6vg --namespace kube-system 查看日志：
kubectl get nodes 查看所有节点:
kubectl attach curl-6bf6db5c4f-btwbm -it tty登录到一个已经运行的pod中
docker attach 有类似 screen 可以共享屏幕的作用
正确的退出姿势 --> 组合键：Ctrl+P+Q
kubectl exec curl-6bf6db5c4f-btwbm -it 
docker run  curl-6bf6db5c4f-btwbm -it 创建并进入容器
kubectl describe service tcpserver-svc 描述一个service
kubectl get nodes --show-labels 带label查看节点
kubectl label node kub1 node-role.kubernetes.io/edge=kub1 给节点打label
docker run -d --restart=always -e DOMAIN=cluster --name nginx-app -p 80:80 nginx

docker  run -e TZ="Asia/Shanghai" --privileged -itd -h jenkin_slave --network=host --name jenkins_slave01   -p 222:22 jenkins/ssh-slave    /usr/sbin/init  #host模式就不能绑定端口

 a9ec34d9878748d2f33dc20cb25c714ff21da8d40558b45bfaec9955859075d0
docker build  -t [newName]:[newVersion] -f /home/build/hellowold/DockerFile  . 编译一个镜像
docker restart pirvi_registry
docker stop pirvi_registry
docker rm -f $(docker ps -a |  grep "zhy*"  | awk '{print $1}')
#删除以"zhy"开头命名的容器
docker run -it --rm --volumes-from data  mysql /bin/bash
#data是添加的数据卷 mysql是镜像
kubectl get pods --all-namespaces -o jsonpath="{..image}" -s http://kubeMaster:8080 |tr -s '[[:space:]]' '\n'   |sort |uniq -c |grep volte
kubectl exec --namespace='volte-test'  vltquartz-2-4105-950q1 -it  bash   -s http://kubeMaster:8080


[sed]
cmd:cat  ~/help/sh/sed_note.sh
[grep]
grep  ^[^#]  /etc/ansible/ansible.cfg 查找非#开头都内容

cmd:cat ~/help/sh/grep_note.sh
[awk]
cmd:cat  ~/help/sh/awk_note.sh
[str_reverse]
str=10572 
echo ${str} Reverse number is  `echo ${str}| rev`
[vim]
u是撤销，ctr + r 是回退上一步
[mysql_back]
#https://www.runoob.com/mysql/mysql-database-export.html
#表库备份
mysql -uroot -ptest123 test -e "select * from emp into outfile '~/test.txt';"
#只导出数据

mysqldump -u root -p database_name table_name > dump.txt
mysql -u root -p database_name < dump.txt
#表结构和数据

echo "load data local infile '/data/data/com.termux/files/home/test.txt' into table emp(empno,ename);"|mysql -uroot -ptest123 test
#emp(empno,ename)不输入字段名导全部数据到emp表，输入字段表示只导指定的字段数据进emp
#导入txt到表
[sort_uniq]
echo "eee:40:5.4 　　
  　　eee:60:5.1 　　
　  　ddd:20:4.2 　　
　  　ccc:50:3.3 　　
  　　bbb:10:2.5 　　
　  　aaa:30:1.6" > sort.txt 　　
　　AAA:BB:CC
sort -nrk 3 -t: sort.txt
#-n是按照数字大小排序，-r是以相反顺序，-k是指定需要爱排序的栏位，-t指定栏位分隔符为冒号
###########################################################################################
#删除重复行：
　　uniq file.txt 　　
　　sort file.txt | uniq 　　
　　sort -u file.txt
#　　只显示单一行：
　　uniq -u file.txt 　　
　　sort file.txt | uniq -u
#　　统计各行在文件中出现的次数：
　　sort file.txt | uniq -c
#　　在文件中找出重复的行：
　　sort file.txt | uniq -d
利用sort和uniq求两个文件的并集，交集和差集
　　并集：cat file1.txt file2.txt | sort | uniq > file.txt
　　交集：cat file1.txt file2.txt | sort | uniq -d >file.txt
　　差集：求file1.txt相对于file2.txt的差集，可先求出两者的交集temp.txt，然后在file1.txt中除去temp.txt即可。
　　　　　cat file1.txt file2.txt | sort | uniq -d >temp.txt
　　　　　cat file1.txt temp.txt | sort | uniq -u >file.txt
[bigdata_install]
hbase作为存储载体,es作为索引载体
E:\elasticsearch-7.5.1-windows-x86_64\elasticsearch-7.5.1\bin
es启动 启动cmd 进入 E:\elasticsearch-7.5.1-windows-x86_64\elasticsearch-5.2.0\bin
执行elasticsearch.bat ..加载日志到started说明成功
http://localhost:9200/?pretty 有返回json说明成功  
E:\elasticsearch-7.5.1-windows-x86_64\elasticsearch-5.2.0\config中修改elasticsearch.yml
kibana作为学习es的主要入口 版本必须es一致  
E:\elasticsearch-7.5.1-windows-x86_64\kibana-5.2.0-windows-x86\bin\kibana.bat
http://localhost:5601/ 进入web kibana界面
############################################################
hbase的Observer同步es
https://blog.csdn.net/weixin_34303897/article/details/89629931?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-2
mysql 同步es 
https://www.csdn.net/gather_23/MtTaIgzsMzU4OC1ibG9n.html

https://github.com/posix4e/Elasticsearch-HBase-River/blob/master/examples/import.sh
###############################################################
【spark】 (scala,py)  E:\hadoop\spark-2.3.4-bin-hadoop2.7\bin 执行spark-shell.cmd 进入scala shell界面操作spark
#https://www.runoob.com/scala/scala-variables.html 
#scala入门
在bin的load-spark-env.cmd 添加
set SPARK_HOME=E:\hadoop\spark-2.3.4-bin-hadoop2.7
set JAVA_HOME=D:\Java\jdk1.8
set SCALA_HOME=E:\hadoop\spark-2.3.4-bin-hadoop2.7\scala-2.12.0
########################################################################
【hadoop】
E:\hadoop\hadoop-2.7.7\etc\hadoop中
按里面参数设置hadoop-env.cmd新增
set JAVA_HOME=D:\Java\jdk1.8
启动E:\hadoop\hadoop-2.7.7\sbin\start-all.cmd
自动开启几个cmd窗口
http://localhost:8088/cluster
http://localhost:50070即可访问
添加hadoop bin到path开起cmd可以执行 hadoop fs -ls /等命令
########################################################################
【开起zookeeper】
E:\hadoop\hapache-zookeeper-3.5.5-bin\bin 执行zkServer.cmd即可
因为hbase启动要用到zk
#######################################################################
【hbase】
E:\hadoop\hbase-1.4.9\conf设置hbase-env.cmd 
set HADOOP_HOME=E:\hadoop\hadoop-2.7.7
set JAVA_HOME=D:\Java\jdk1.8
#不用使用program目录里面有空格启动会报错
E:\hadoop\hbase-1.4.9\bin\start-hbase.cmd 启动
可设置到path ；hbase shell 进入cli
########################################################################
【hive】
hive-site.xml中替换这两项路径
  <property>
    <name>hive.exec.local.scratchdir</name>
    <value>E:\hadoop\hive-2.3.5-bin\tmp\admin</value>
    <description>Local scratch space for Hive jobs</description>
  </property>
  <property>
    <name>hive.downloaded.resources.dir</name>
    <value>E:\hadoop\hive-2.3.5-bin\tmp/${hive.session.id}_resources</value>
    <description>Temporary local directory for added resources in the remote file system.</description>
  </property>
在E:\hadoop\hive-2.3.5-bin\bin中hive.cmd添加
set HADOOP_HOME=E:\hadoop\hadoop-2.7.7
启动hive执行hive.cmd
#########################################################################
[go_test]
#########################################################################
package main
import "fmt"
type HelloWorld struct{}
func (_ *HelloWorld) PrintHello() {
	fmt.Println("hello")
}
func (_ *HelloWorld) PrintWorld() {
	fmt.Println("world")
}
########################################################################
package main
import (
	"testing"
)
// 单元测试  test必须文件是test结尾，函数必须Test开头，参数必须是t *testing.T
func TestHelloWorld(t *testing.T) {
	t.Log("hello world")
}
// 性能测试  //Benchmark基准测试  函数必须Benchmark开头。参数必须是b *testing.B
func BenchmarkHelloWorld(b *testing.B) {
	a1 := 100
	b1 := 2
	c1 := a1 / b1
	b.Log("hello world", c1)
}
// 覆盖率测试
func TestHelloWorld_PrintHello(t *testing.T) {
	h := &HelloWorld{}
	h.PrintHello()
}
#go test -run . -bench=. 
#当前文件中执行所有基准函数
#go test -run 文件名 -bench=TestHelloWorld_PrintHello -count=30
#指定函数，指定次数
#########################################################################
LiteIDE 编译->go moduce init 自动创建mod文件，点击编译自动下载引用的第三方包
[spark]
#########################################################################
RDD（Resilient Distributed Dataset）叫做弹性分布式数据集，是Spark中最基本的数据抽象，它代表一个不可变、可分区、里面的元素可并行计算的集合。RDD具有数据流模型的特点：自动容错、位置感知性调度和可伸缩性。RDD允许用户在执行多个查询时显式地将数据缓存在内存中，后续的查询能够重用这些数据，这极大地提升了查询速度
代替MapReduce
RDD是一种具有容错性、基于内存计算的抽象方法，RDD是Spark Core的底层核心，Spark则是这个抽象方法的实现。
3. 创建RDD
1）由一个已经存在的Scala集合创建。
val rdd1 = sc.parallelize(Array(1,2,3,4,5,6,7,8))
2）由外部存储系统的文件创建。包括本地的文件系统，还有所有Hadoop支持的数据集，比如HDFS、Cassandra、HBase等。
val rdd2 = sc.textFile("/words.txt")
3）已有的RDD经过算子转换生成新的RDD
val rdd3=rdd2.flatMap(_.split(" "))
//scala定义一个列表
val list: List[Int] = List(1, 2, 3, 4, 5, 6, 7)
//生成一个rdd
val rdd: RDD[Int] = sc.parallelize(list)
//filter算子
val map: RDD[Int] = rdd.filter(_ > 5)
//foreach 算子打印
map.foreach(x => println(x))
sc.stop()
#在Spark中创建RDD的创建方式大概可以分为三种：（1）、从集合中创建RDD；（2）、从外部存储创建RDD；（3）、从其他RDD创建。
#集群启动spark：spark-shell --master spark://node-1:7077 
#RDD函数大致如下:
map#map是对RDD中的每个元素都执行一个指定的函数来产生一个新的RDD
filter#filter 是对RDD中的每个元素都执行一个指定的函数来过滤产生一个新的RDD
flatMap#与map类似，区别是原RDD中的元素经map处理后只能生成一个元素，而原RDD中的元素经flatmap处理后可生成多个元素来构建新RDD
mapPartitions#
mapPartitionsWithIndex
mapWith
flatMapWith
coalesce
repartition
randomSplit
glom
union并集
distinct
intersection交集
subtractByKey
groupbyKey
reduceByKey
sortByKey
sortBy
zip
zipPartitions
zipWithIndex
zipWithUniqueId
partitionBy
mapValues
flatMapValues
combineByKey
foldByKey
reduceByKeyLocally
cogroup和groupByKey的区别
join
leftOuterJoin
rightOuterJoin
first
count
reduce
take
top
takeOrdered
aggregate
fold
lookup
countByKey
foreach
foreachPartition
sortBy
saveAsTextFile
saveAsSequenceFile
saveAsObjectFile
saveAsHadoopFile
saveAsHadoopDataset
saveAsNewAPIHadoopFile
saveAsNewAPIHadoopDataset
#https://blog.csdn.net/weixin_41615494/article/details/79533042
# 普通数据--》SparkRDD-》SchemaRDD（dataFrame）-》sparkSQL
sparkSQL操作####################################################################
user.json#内容如下
{"age":"45","gender":"M","occupation":"7","userID":"4","zipcode":"02460"}{"age":"1","gend er":"F","occupation":"10","userID":"1","zipcode":"48067"}
hadoop dfs -put user.json /user
#进入spark-shell的scala cli界面
val spark=new org.apache.spark.sql.SQLContext(sc)
scala>val userDF=spark.read.json("/user/user.json")
scala>userDF.show(2)   #查看数据
scala> userDF.limit(2).toJSON.foreach(x =>println(x))
scala> userDF.printSchema
scala>userDF.select("userID","age").show   #查询数据
scala>userDF.select(max("age"),min("age"),avg("age")).show
scala>userDF.select("userID", "age").filter("age > 30").show(2)
scala>userDF.filter("age > 30").select("userID", "age").show(2)  #过滤数据
scala> userDF.groupBy("age").count().show()
scala> userDF.groupBy("age").agg(count("gender")).show()
scala> userDF.groupBy("age").agg(countDistinct("gender")).show()
scala> userDF.groupBy("age").agg("gender"->"count","occupation"->"count").show()

groupBy().agg(aggExpr, aggExprs : _*)
还有max、mean、min、sum、avg、explode、size、sort_array、day、to_date、abs、acros、asin、atan
总体上而言内置函数包含了五大基本类型：
1、聚合函数，例如countDistinct、sumDistinct等；
2、集合函数，例如sort_array、explode等
3、日期、时间函数，例如hour、quarter、next_day
4、数学函数，例如asin、atan、sqrt、tan、round等；
5、开窗函数，例如rowNumber等
6、字符串函数，concat、format_number、rexexp_extract
7、其它函数，isNaN、sha、randn、callUDF
Spark SQL支持多部分的Hive特性，例如：
#https://www.cnblogs.com/xinfang520/p/7987378.html
#https://www.cnblogs.com/wangbin2188/p/8252797.html
##########################################################################
[ES]
############################################################################
curl localhost:9200/_cat/master?help
#分kibana的http请求和curl命令请求
GET /customer/doc/1?pretty
curl -XGET 'localhost:9200/customer/doc/1?pretty&pretty'

DELETE /customer?pretty
GET /_cat/indices?v
curl -XDELETE 'localhost:9200/customer?pretty&pretty'
curl -XGET 'localhost:9200/_cat/indices?v&pretty'

PUT /customer/doc/1?pretty
{
	  "name": "John Doe"
  }
curl -XPUT 'localhost:9200/customer/doc/1?pretty&pretty' -H 'Content-Type: application/json' -d'

$ curl http://node1:9200/_cat/indices?v #indices 可以替换上文中的所有命令
#创建索引库 bigdata_p
$ curl -XPUT http://master:9200/bigdata_p 
#POST和PUT都可以用于创建，二者之间的区别： 
#PUT是幂等方法，POST不是。所以PUT用于更新，POST用于新增比较合适。 
$ curl -XPOST http://localhost:9200/bigdata/product/ -d '{"author" : "Doug Cutting"}' 
$ curl -XPUT http://master:9200/bigdata_p/product/ -d '{"name"："hadoop", "author": "Doug Cutting", "c_version": "2.7.3"}' 
#查询某一个索引库中的数据
$ curl -XGET http://master:9200/bigdata_p/_search?pretty 
#如果要查询多个字段，使用","进行隔开。eg. 
$ curl -XGET http://master:9200/bigdata_p/product/1?_source=name,author&pretty
#获取source所有数据 
$ curl -XGET http://master:9200/bigdata_p/product/1?_source&pretty 
#根据条件进行查询 
$ curl -XGET http://master:9200/bigdata_p/product/_search?q=name:hbase,hive&pretty
[jq]
echo '{"foo": 42, "bar": "less interesting data"}' | jq .bar

#json_raw.txt如下
{"name":"Google","location":{"street":"1600 Amphitheatre Parkway","city":"Mountain View","state":"California","country":"US"},"employees":[{"name":"Michael","division":"Engineering"}{"name":"Laura","division":"HR"},{"name":"Elise","division":"Marketing"}]}
cat json_raw.txt | jq '.location.state'
#JSON nested parse（嵌套解析）

cat json_raw.txt | jq '.employees[1].name'

cat json_raw.txt | jq 'keys'

cat json_raw.txt | jq 'has("name")'
# has是用来是判断是否存在某个key： 
cat json_raw.txt | jq 'has("noexisted")'
#https://www.ibm.com/developerworks/cn/linux/1612_chengg_jq/
[py_gil]
############################################################################
#②Lock在锁定时不属于特定线程，也就是说，Lock可以在一个线程中上锁，在另一个线程中解锁。而对于RLock来说，只有当前线程才能释放本线程上的锁，即解铃还须系铃人：
#queue是线程安全的list是不安全的 全局变量是线程是可见的，需要加锁来确保线程安全
#https://github.com/TwoWater/Python/blob/master/Article/PythonBasis/python13/2.md
线程和进程
Python 中的多线程其实并不是真正的多线程，如果想要充分地使用多核 CPU 的资源，在 Python 中大部分情况需要使用多进程。进程相当于一个程序，线程基于进程的逻辑细分个人理解
【线程池和进程池】
#Python标准库为我们提供了threading和multiprocessing模块编写相应的多线程/多进程代码，但是当项目达到一定的规模，频繁创建/销毁进程或者线程是非常消耗资源的，这个时候我们就要编写自己的线程池/进程池，以空间换时间。但从Python3.2开始，标准库为我们提供了concurrent.futures模块，它提供了ThreadPoolExecutor和ProcessPoolExecutor两个类
concurrent.futures模块的基础是Executor，Executor是一个抽象类，它不能被直接使用。但是它提供的两个子类ThreadPoolExecutor和ProcessPoolExecutor却是非常有用
#Python的多线程在多核CPU上，只对于IO密集型计算产生正面效果；而当有至少有一个CPU密集型线程存在，那么多线程效率会由于GIL而大幅下降
如何避免受到GIL的影响
用multiprocess替代Thread
它完整的复制了一套thread所提供的接口方便迁移。唯一的不同就是它使用了多进程而不是多线程。每个进程有自己的独立的GIL，因此也不会出现进程之间的GIL争抢
当然multiprocess也不是万能良药。它的引入会增加程序实现时线程间数据通讯和同步的困难。就拿计数器来举例子，如果我们要多个线程累加同一个变量，对于thread来说，申明一个global变量，用thread.Lock的context包裹住三行就搞定了。而multiprocess由于进程之间无法看到对方的数据，只能通过在主线程申明一个Queue，put再get或者用share memory的方法。这个额外的实现成本使得本来就非常痛苦的多线程程序编码，变得更加痛苦了
并发：一个时间段内，有几个程序在同一个CPU上运行，但是任意时刻只有一个程序在CPU上运行。
并行：并行是指任意时刻上，有多个程序同时运行在多个CPU
#对于耗 CPU 的操作，用多进程优于多线程，因为有 GIL 锁，不会常释放，耗 CPU 操作无法使用多线程。
#多 IO 操作，常会释放 GIL，所以可以多使用多线程

Python标准库为我们提供了threading和multiprocessing模块编写相应的多线程/多进程代码，但是当项目达到一定的规模，频繁创建/销毁进程或者线程是非常消耗资源的，这个时候我们就要编写自己的线程池/进程池，以空间换时间。但从Python3.2开始，标准库为我们提供了concurrent.futures模块，它提供了ThreadPoolExecutor和ProcessPoolExecutor两个类，实现了对threading和multiprocessing的进一步抽象，对编写线程池/进程池提供了直接的支持。

1.from Queue import Queue
这个zhidao是普通的队列模式，类似于普通列表，先进先出模式，get方法会阻塞请求，直到有数据get出来为止

2.from multiprocessing.Queue import Queue
这个是多进版程并发权的Queue队列，用于解决多进程间的通信问题。普通Queue实现不了。例如来跑多进程对一批IP列表进行运算，运算后的结果都存到Queue队列里面，这个就必须使用multiprocessing提供的Queue来实现 
[notepad]             
cmd /k D:\Python36\python.exe "$(FULL_CURRENT_PATH)" & PAUSE & EXIT
[go]
Go 语言在语言级别支持轻量级线程，叫goroutine。Go 语言标准库提供的所有系统调用操作
（当然也包括所有同步 IO 操作），都会出让 CPU 给其他goroutine。这让事情变得非常简单，让轻
量级线程的切换管理不依赖于系统的线程和进程，也不依赖于CPU的核心数量。

channel是Go语言在语言级别提供的goroutine间的通信方式。我们可以使用channel在两个或
多个goroutine之间传递消息。channel是进程内的通信方式，因此通过channel传递对象的过程和调
用函数时的参数传递行为比较一致
channel是类型相关的。也就是说，一个channel只能传递一种类型的值，这个类型需要在声
明channel时指定。 
channel基于先进先出FIFO 队列，对 FIFO 队列的读写都是原子的操作，不需要加锁
#thread和进程的数目是有限的，一般的电脑可以同时开的thread数量大概几千个。而GO语言可以开启的goroutine，却可以达到几百万个，因此很显然goroutine不等于thread


对于一个 goroutine 来说，当它被创建的时候，有一个初始的内存使用量确定为2KB
当一个 goroutine 在运行的过程中如果需要使用更多的内存，那么它将会在 Heap 上申请。
对于 Guard Page 的问题，goroutine 采取了一种「用前检查」的方式来解决：每当一个函数调用的时候，go runtime 都会去检查当前 goroutine 的 stack 空间是否够用，如果不够就在 Heap 上分配一块新的空间，该块空间使用完还会被回收。
这种「用前检查」的动态分配内存的方式使得 goroutine 在内存的消耗上相较于 thread 来说具有明显的优势。所以在写 golang 程序的时候，我们几乎可以对收到的每一个 Request 都开一个 goroutine 处理。但是如果使用 thread这么做的话，你就等着 OOM 吧:)。上面的描述并不代表对于 goroutine 你就可以随意分配使用而不及时回收，如果 goroutine 数量太多它一样会 OOM，只不过 goroutine 相较于 thread 的内存增长率要低很多罢了。在同等的量级下，thread 会引起程序 OOM 但是 goroutine 不会。
thread

线程的创建和销毁都需要通过系统调用来实现，也就是说，这些动作都必须要和 OS 的内核进行交互。
goroutine

goroutine 的创建和销毁操作都是由 go runtime 来完成的，在用户空间下直接进行处理。
对于创建和销毁的性能问题，这里不做过多介绍。本质上来说，goroutine 和 thread 就相当于「用户级线程」和「内核级线程」。感兴趣的可以去找下相关资料深入了解下两者的区别。否则，可以简单的理解为「goroutine 的创建和销毁是程序自己做的，但是 thread 得麻烦 OS 的内核，两者的性能当然不一样」

我们之前喊过一句口号，倡导用通信来共享数据，而不是通过共享数据来进行通信，但考虑
到即使成功地用channel来作为通信手段，还是避免不了多个goroutine之间共享数据的问题，Go
语言的设计者虽然对channel有极高的期望，但也提供了妥善的资源锁方案
#如果能用channel解决的就不用锁，但有时可能用非channel得方式共享数据就需要锁来确保线程安全
代码里只给并发不安全的传统map加过锁，其他并发共享数据的地方基本都是chan


Go语言包中的 sync 包提供了两种锁类型： sync.Mutex 和 sync.RWMutex 。 Mutex 是最简单
的一种锁类型，同时也比较暴力，当一个goroutine获得了 Mutex 后，其他goroutine就只能乖乖等
到这个goroutine释放该 Mutex 。 RWMutex 相对友好些，是经典的单写多读模型。在读锁占用的情
况下，会阻止写，但不阻止读，也就是多个goroutine可同时获取读锁（调用 RLock() 方法；而写
锁（调用 Lock() 方法）会阻止任何其他goroutine（无论读和写）进来，整个锁相当于由该goroutine
独占。从 RWMutex 的实现看， RWMutex 类型其实组合了 Mutex ：

Go从1.5版本开始，默认采用多核执行，默认是你的CPU核心数，以前版本默认为1   

写 ch <- 	一直阻塞 	panic 	            阻塞或成功写入数据
读 <- ch 	一直阻塞 	读取对应类型零值 	阻塞或成功读取数据

Go 允许使用 go 语句开启一个新的运行期线程， 即 goroutine，以一个不同的、新创建的 goroutine 来执行一个函数。 同一个程序中的所有 goroutine 共享同一个地址空间。
package main

import (
	"fmt"
	"time"
)

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}
func main() {
	go say("world")
	say("hello")
}
#####输出######
world
hello
hello
world
world
hello
hello
world
world
hello
#########################
package main
import "fmt"
func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	fmt.Println(sum)
	c <- sum // 把 sum 发送到通道 c
}
func main() {
	s := []int{7, 2, 8, -9, 4, 0}

	c := make(chan int)
	go sum(s[:len(s)/2], c) //17
	go sum(s[len(s)/2:], c) //-5
	x, y := <-c, <-c        // 从通道 c 中接收
	fmt.Println(x, y, x+y)
}
#########输出            ########
-5
17
-5 17 12
#####################################
package main

import (
	"fmt"
	"time"
)

func main() {
	running := true
	f := func() {
		for running { //控制的全局共享变量
			fmt.Println("sub proc running...")
			time.Sleep(1 * time.Second)
		}
		fmt.Println("sub proc exit")
	}
	go f()
	//go f()
	//f()
	fmt.Println("main world")
	time.Sleep(3 * time.Second)
	fmt.Println("main hello")
	running = false //全局共享变量改变
	time.Sleep(3 * time.Second)
	fmt.Println("main proc exit")
}
###############结果###################
main world
sub proc running...
sub proc running...
sub proc running...
main hello
sub proc running...
sub proc exit
main proc exit
##################################
package main

import (
	"fmt"
	_ "os"
	_ "os/signal"
	"sync"
	_ "syscall"
	"time"
)

//执行的go程方法，传入的chan
func consumer(stop <-chan bool) {
	for {
		select { //机制类似epoll
		case <-stop:
			fmt.Println("exit sub goroutine")
			return
		default:
			fmt.Println("running...")
			time.Sleep(500 * time.Millisecond)
		}
	}
}
func main() {
	stop := make(chan bool)
	var wg sync.WaitGroup
	// Spawn example consumers
	for i := 0; i < 3; i++ {
		wg.Add(1) //创建一个任务
		go func(stop <-chan bool) {
			defer wg.Done() //任务完成的时候使用wg.Done()来将任务减一
			consumer(stop)
		}(stop) //并发匿名函数
	}
	close(stop) //直接关闭chan，否则传递3次信号量
	fmt.Println("stopping all jobs!")
	wg.Wait() //wg.Wait()来阻塞等待所有任务完成。
	fmt.Println("OVER")
}
#################################
exit sub goroutine
stopping all jobs!
exit sub goroutine
exit sub goroutine
OVER


#Lock（）：通过获取锁，一次只能读取/写入一个go例程。
#RLock（）：通过获取锁，多个go例程可以一次读取（而不是写入）。
import "time"
import "sync"
func main() {
	var mutex sync.Mutex
	for i := 0; i < 10; i++ {
		go func(i int) {
			mutex.Lock()
			fmt.Println(i)
			mutex.Unlock()
		}(i)
	}
	time.Sleep(500 * time.Millisecond)//主程序没有goroutine保持生命周期，可能什么都不打印
}
[websocket]
netty是对socket的封装
通信协议从广义上区分，可以分为公有协议和私有协议。由于私有协议的灵活性，它往往会在某个公司或者组织内部使用，按需定制，也因为如此，升级起来会非常方便，灵活性好。绝大多数的私有协议传输层都基于TCP/IP，所以利用Netty的NIO TCP协议栈可以非常方便地进行私有协议的定制和开发。
在传统的Java应用中，通常使用以下4种方式进行跨节点通信。

（1）通过RMI进行远程服务调用；
（2）通过Java的Socket+Java序列化的方式进行跨节点调用；
（3）利用一些开源的RPC框架进行远程服务调用，例如Facebook的Thrift，Apache的Avro等；
（4）利用标准的公有协议进行跨节点服务调用，例如HTTP+XML、RESTful+JSON或者WebService。
使用Netty提供的异步TCP协议栈开发一个私有协议栈，该协议栈被命名为Netty协议栈。Netty协议栈用于内部各模块之间的通信，它基于TCP/IP协议栈，是一个类HTTP协议的应用层协议栈，相比于传统的标准协议栈，它更加轻巧、灵活和实用。

（1）基于Netty的NIO通信框架，提供高性能的异步通信能力；
（2）提供消息的编解码框架，可以实现POJO的序列化和反序列化；
（3）提供基于IP地址的白名单接入认证机制；
（4）链路的有效性校验机制；
（5）链路的断连重连机制。
#不过任何东西都有两面，现对比一下两者优缺点：
1. 使用netty的优缺点：
优点：高效、稳定、
缺点：代码量稍多、要维持长链接、消息如果要持久化需要单独处理
2. MQ的优缺点：
优点：编程简单、消息可持久化
缺点： 可能要搭建单独的MQ服务器、稳定性不高、效率偏低

#协议开发步骤
数据结构定义
消息编解码
握手和安全认证
心跳检测机制
断连重连

[测试]
dom操作
创建webdrive 对象调用url方法打开浏览器
assertEqual断言
find element by id ,name ,classname,flag xpath css_selector
sendkey 输入
submit 提交
sleep 设置等待时间
###########################
性能测试首先要确定性能测试的指标和需求
根据需求定制采取性能测试方案
不能一开就使用工具进行盲测

用户吞吐量越大，响应时间越长。
服务器硬件配置越高，吞吐量越大。
网络越差，吞吐量越小。
QPS（TPS）：每秒钟request/事务 数量
QPS（TPS）= 并发数/平均响应时间

每天300w PV 的在单台机器上，这台机器需要多少QPS？
二八原则百分之二的时间完成百分之80的pv量
答：( 3000000 * 0.8 ) / (86400 * 0.2 ) = 139 (QPS)
如果一台机器的QPS是58，需要几台机器来支持？
答：139 / 58 = 3

程序本身的效率低(或某个函数效率低下)    cup io 内存，db ，硬盘，网络流量，还是链路层，cdn 反向代理，还是容器层
cdn 就近网络分发(内容分发网络)

发现性能问题
性能测试并不是指使用工具对web的请求进行测试，后台程序也需要性能测试
可以压测接口，
代码也能发现性能测试问题


淘宝性能测试环境下，将这个概念做了延伸，系统真实处理的一个请求，视
为一个 PV。即，PV的概念也适用于接口。

日预估PV=压测QPS * （24*60*60*时间百分比）/0.8 * 机器数量

我们通过每日的QPS和PV统计图表可以发现，每日的曲线基本都是一致的。通过数学建模，我们可以发现高峰每台服务器QPS=( (总 PV*80%)/(24*60*60*40%))/服务器数量1。其中80%和40%这2个数字是个不固定的参数，这个公式代表的意思是，在40%的时间（12小时）内产生80%总pv的QPS均值。对于不同的情景有不同的参数。

公式1：每天总PV = QPS * 3600 * 6
公式2：每天总PV = QPS * 3600 * 8
独立访客即Unique Visitor,访问您网站的一台电脑客户端为一个访客。00:00-24:00内相同的客户端只被计算一次

吞吐量是指系统在单位时间内处理请求的数量
响应时间（RT):
响应时间是指系统对请求作出响应的时间

loadrunner函数
Loadrunner中所支持的脚本语言是c
用LoadRunner进行负载测试的流程通常由五个阶段组成：
　　计划、脚本创建、场景定义、场景执行和结果分析。
　　(1)计划负载测试：定义性能测试要求，例如并发用户的数量、典型业务流程和所需响应时间。
　　(2)创建 Vuser 脚本：将最终用户活动捕获到自动脚本中。参数化，检查点，关联，              
　　(3)定义场景：使用 LoadRunner Controller 设置负载测试环境。
　　(4)运行场景：通过 LoadRunner Controller 驱动、管理和监控负载测试。
　　(5)分析结果：使用 LoadRunner Analysis 创建图和报告并评估性能
[推导式]
 [ i for i in map(lambda x, y: x + y, [1, 3, 5, 7, 9], [2, 4, 6, 8, 10]) ]
#[3, 7, 11, 15, 19]

 [f2(2) for f2 in  [lambda x, i=i: x*i for i in range(10)]] 
 [i*i for i in range(10)]]#也可以把i当做参数传给指定函数或表达式
#[0, 2, 4, 6, 8, 10, 12, 14, 16, 18]


#[1, 2, 7]
filter(is_odd, [1, 2, 4, 5, 6, 9, 10, 15])
 [i for i in [1, 2, 4, 5, 6, 9, 10, 15] if i  % 2 == 1 ]

#数组反序
sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)

a=['bob', 'about', 'Zoo', 'Credit']
 [a[len(a)-i-1] for i in range(len(a))]
 a[::-1]//这种数组取反最爽同时支持字符反序           
 a[:-1]//删除最后一个元素 a[:-2]删除最后2个元素
 
#支持list和字符反序列
a="abc"
''.join([a[len(a)-i-1] for i in range(len(a))])
"abc"[::-1]
#"cba"

#数组去重
li=[1,2,3,4,5,1,2,3]
 [i for i in {}.fromkeys(li).keys()]
 [i for i in dict(zip(li,li)).keys()]
i=list(set(li))//乱序
list({i for i in a})

#lst = [1, 2, 4, 5, 5, 5, 4, 7]
#print filter(lambda x: lst.count(x)<2, lst)

数组排序
a=[1, 2, 4, 4, 5, 6,11,5, 5, 7]
a.sort()//升序
a.sort(reverse=True)//降序
print (a)
max(a)
min(a)
a.append(8)
#获取最长字符的元素
a=['aaa', 'ssss', 'z']
 [i for i in a if len(i)==max([len(i) for i in a]) ][0]
#数组元素的长度进行升序排序
a=['aaa', 'ssss', 'z']
b=[len(i) for i in a]
b.sort()
 [i  for j in b  for i in a  if len(i)==j]
#必须b的for在前面，不然不会排序

#获取数组中重复次数最多的元素
a=[11, 7, 6, 5, 5, 5, 4, 4, 2, 1, 8]
set([i for i in a if a.count(i)==max([a.count(i) for i in a])])

#获取和6最靠近的值
a=[11, 7, 6, 5, 5, 5, 4, 4, 2, 1, 8]
a.remove(6)//删除一个6，如果有多个6只会删一个，abs是绝对值函数
{i for i in a if  abs(6-i)==min([ abs(6-i) for i in a  ])}
#按照元素与5距离从小到大进行排序
sorted([1, 2, 3, 4, 5, 6, 7, 8, 9], key=lambda x: abs(5-x))
##############################找出头部共性的部分且不能包含大写字母#############################################
a=["flowe","flew","flow","Flight","Fligh"]
max_len=max([len(i) for i in a])#获取数组最长元素的长度
while 1:
    #使用列表解析式的写法更加简短，除此之外，因为是Python内置的用法，底层使用c语言实现，相较于编写Python代码而言，运行速度更快。
    max_len-=1
    b=[i[:max_len] for i in a ]
    max_b=max([b.count(i) for i in b])
    c=set([i for i in b if max_b==b.count(i) and  i.islower()] )
    if c:
        print (c)
        break
################################结果{"flow"}     
#效率问题 map(高阶函数)>推导式>for普通循环
#同样，字典、元组也可以被推导
#map可以带条件和else 推导式只能if
task = ['task1', 'task2', 'task3', 'task4']
s = map(lambda x: x + '_finished' if x[len(x) - 1:] == "2" else x, task)
print(list(s))
####result:['task1', 'task2_finished', 'task3', 'task4']
def m(aa):     
	from functools import reduce
	return reduce(lambda x1,x2:x2*2,aa)
m([22,44])
结果是88  
reduce(lambda  x,y:x*x+y*y,  range(1,3))
#1*1+2*2+....
list(map( lambda x, y: ( x * y, x + y), [1, 2, 3], [4, 5, 6]))
#[(4, 5), (10, 7), (18, 9)]
#对第一个元素元祖的第一个下标进行排序
a= [('b', 4), ('a', 12), ('d', 7), ('h', 6), ('j', 3)]
a.sort(key=lambda x: x[0])
print(a)
x = [3, 2.2, -7.4, 6, 4]
max(x, key=abs)

