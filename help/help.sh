    case $1 in
rand|随机 )
	echo "
	echo | awk  '{ srand(); print rand() }'"
		;;
$|参数)
	echo "
	\$0 这个程式的执行名字
	\$n 这个程式的第n个参数值，n=1..9
	\$* 这个程式的所有参数,此选项参数可超过9个。
	\$# 这个程式的参数个数
	\$$ 这个程式的PID(脚本运行的当前进程ID号)
	\$! 执行上一个背景指令的PID(后台运行的最后一个进程的进程ID号)
	\$? 执行上一个指令的返回值 (显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误)
	\$- 显示shell使用的当前选项，与set命令功能相同
	\$@ 跟\$*类似，表示所有参数用 "
		;;
find)
	echo "
	find . -type f  -name '*.sh'    |xargs -i cp {} ~/sh/
	#复制和find组合
	ls | grep -P '[^!-~]' | xargs -i cp {} ~/sh/
	#赋值包含汉字的文件名" ;;
list|数组|str)
	echo "
	a=3
	b=(\`for i in {1..6}; do if [[ \$i >\$a ]]; then echo \$i; else echo \"haha\"; fi; done\`)
	aa=\$(for j in {1..7};do  python -c \"print [i for i in range(1,9) ][\$j]\";done);echo \${aa[@]}
	echo \"list first values is \${b[0]}\"
	echo  \"list last values is \${b[-1]}\"
	echo  \"list length is \${#b[@]}\",\${#b[*]}
	echo \"list values is '\${b[@]}'\",\${b[*]}"
	echo "	aaa=\"aa,bb,ccc\";bb=(\`echo \$aaa |sed 's/,/\\n/g'\`);echo  \${bb[-1]} 

	echo \"aa ,bb,aaa\" | awk '{split(\$0,arr,\",\");for(i in arr) print i,arr[i]}'"
	;;
tar|rm)
	echo "
	rm  -R *ļ* //删乱码文件夹
	tar -zcvf 123.tar.gz  dir_name 压缩
	tar -zxvf 123.tar.gz  解压 ";;
null)
	echo "	uname1 2>/dev/null ;uname 2>/dev/null 
	//错误的命令不输出，只输出对的命令" ;;
	set)
	echo "set -e //遇到错误立即退出脚本
	set +e //遇到错误，跳过错误继续执行脚本";;
	expr|运算)
	echo "eval $v1='$vaaa' ; echo aaa: \$aaa";;
 
rm|messy)
	
	echo "	ls -i #find dir inode number 
	find -inum 2236429 -exec rm -rf {} \; 
	#delete file by inode,if rm error redo too";;
ln)
	echo "	ln -s /opt/mcb/bin  qq #creat softlink qq
	#delete qq as del softlink";;
kuohao|括号|:=|:)
	echo "	# var=test
	# echo \$var
	test
	# (var=notest;echo \$var)
	notest
	# echo \$var
	test
	# { var=notest;echo \$var;}
	notest
	# echo \$var
	notest
	\${var:=string} #:-是临时替换当var变量为空就替换后面的字符串
	# :=是直接替换也是当为空才替换，不为空就不替换
	# :+ 是当不为空就临时替换，为空就不替换
	# :? 是当不为空就直接替换，为空就不替换
	#注：冒号:可省略
	# https:#www.cnblogs.com/HKUI/p/6423918.html
	" ;;   
expr|str|切片)
	echo "	echo \$((a=3+2)) #会打印5 ,
	echo \$((a++)) #自增，echo 变量会打印6
	# \${var#pattern}    匹配前缀（最小匹配），并返回余下内容
	# \${var##pattern}    匹配前缀（最大匹配），并返回余下内容
	# \${var%pattern}    匹配结尾（最小匹配），并返回余下内容
	# \${var%%pattern}    匹配结尾（最大匹配），并返回余下内容
	file=/dir1/dir2/dir3/my.file.txt      
	echo \${file#*/}  # 拿掉第一条 / 及其左边的字符串
	#结果 dir1/dir2/dir3/my.file.txt
	echo \${file##*/}  # 拿掉最后一条 / 及其左边的字符串
	#结果 my.file.txt
	 echo \${file%/*} #正好和前面的相反，匹配后缀，通配符*必须在匹配部分的右边才生效
	#结果 /dir1/dir2/dir3 
	# https://www.cnblogs.com/chengd/p/7803664.html
	
	\${file:0:5}         #　提取最左边的 5 个字节    　　　　　　　　/dir1
	\${file:5}           #  提取最左边的第5个字符到结束
	\${file:0-5}         #  提取最右边的倒数5个字符到结束
	\${file:0-5:5}       #  提取最右边的倒数5个字符 ,右边的连续 5 个字节
	\${file:5:5}         #　提取第 5 个字节右边的连续 5 个字节    　 /dir2
	\${file/dir/path}    #  将第一个 dir 提换为 path    　　　　　　 /path1/dir2/dir3/my.file.txt
	\${file//dir/path}   #  将全部 dir 提换为 path    　　　　　　　 /path1/path2/path3/my.file.txt
	\${#file}    　　　　#　获取变量长度    　　　　　　　　　　　　 27  ";;
exp|bc|let|计算)
	echo "
	expr substr abcde 2 2 #从第2位截取2个长度 ，结果是bc
	expr length 111       #结果是3
	expr 4 + \$a          #结果7 变量a为3
	expr $a \* 4          #结果为12 ，*是元字符需转义
	let  a=5+4          # let  命令是 BASH 中用于计算的工具
	echo \"1.212*3\" | bc   # bc 命令是 BASH 中用于计算的工具
	echo \"scale=2;3/8\" | bc   #参数scale=2是将bc输出结果的小数位设置为2位
	";; 
vim)
	echo "	#vim多行编辑， ctr +v 是列模式
	#Ctrl+v 进入列编辑模式。向下或向上移动光标，把需要注释的行的开头标记起来，
	#然后按大写的I，再插入注释符，比如“#”，再按Esc。就会全部注释了。
	:2,50 s/^/#/g 在2~50 行首添加 # 号注释
	:% s/^/#/g 来在全部内容的行首添加 # 号注释
	/super  或者  ？super，  两者的区别是前者是从上往下搜索，后者是从下往上搜索。
	:0或:1 到第一行,:$ 到最后一行
	vim 无法保存时，可能是没权限，或执行:wq!
	";;

\<|cat)
	echo "	
	foo(){
	while read line;do
	while read tag;do
	echo \$tag
	done < <(\$@_2 \$line )
	#<( command )是命令或者函数输出当作文件
	# \$@_2 \$line 就是调用 test_2 test 
	done < <(\$@_1)
	}
	test_1(){
	seq 2 4
	}
	test_2(){
	seq 1 \$@
	}
	foo test
	
	#done是前面do的结束语句
	#\< namefile是从namefile读取内容 
	cat > qq           #回车 会进入输入模式，输入aaa字符串 trl +c 退出，cat qq 会打印aaa
	cat >bb<qq       #会把qq的内容重定向到新文件bb
	cat >bb<< eof #回车会进入输入模式，输入字符bbb，再回车输入eof 和前面效果一样。eof必须成对，必须同时大写或同时小写

	";;
if)
	echo "	# https://blog.csdn.net/jasonzeng/article/details/53286384
	# https://www.cnblogs.com/aaronLinux/p/7074725.html

	1、[ ]表示条件测试。注意这里的空格很重要。要注意在'['后面和']'前面都必须要有空格
	2、在shell中，then和fi是分开的语句。如果要在同一行里面输入，则需要用分号将他们隔开。
	3、注意if判断中对于变量的处理，需要加引号，以免一些不必要的错误。
	没有加双引号会在一些含空格等的字符串变量判断的时候产生错误。比如[ -n \"\$var\" ]如果var为空会出错
	4、判断是不支持浮点值的
	5、如果只单独使用>或者<号，系统会认为是输出或者输入重定向，虽然结果显示正确，但是其实是错误的，因此要对这些符号进行转意
	6、在默认中，运行if语句中的命令所产生的错误信息仍然出现在脚本的输出结果中
	7、使用-z或者-n来检查长度的时候，没有定义的变量也为0
	8、空变量和没有初始化的变量可能会对shell脚本测试产生灾难性的影响，因此在不确定变量的内容的时候，在测试号前使用-n或者-z测试一下
	9、? 变量包含了之前执行命令的退出状态（最近完成的前台进程）（可以用于检测退出状态）
	
	文件/目录判断：

	[ -a FILE ] 如果 FILE 存在则为真。
	[ -b FILE ] 如果 FILE 存在且是一个块文件则返回为真。
	[ -c FILE ] 如果 FILE 存在且是一个字符文件则返回为真。
	[ -d FILE ] 如果 FILE 存在且是一个目录则返回为真。
	[ -e FILE ] 如果 指定的文件或目录存在时返回为真。
	[ -f FILE ] 如果 FILE 存在且是一个普通文件则返回为真。
	[ -g FILE ] 如果 FILE 存在且设置了SGID则返回为真。
	[ -h FILE ] 如果 FILE 存在且是一个符号符号链接文件则返回为真。（该选项在一些老系统上无效）
	[ -k FILE ] 如果 FILE 存在且已经设置了冒险位则返回为真。
	[ -p FILE ] 如果 FILE 存并且是命令管道时返回为真。
	[ -r FILE ] 如果 FILE 存在且是可读的则返回为真。
	[ -s FILE ] 如果 FILE 存在且大小非0时为真则返回为真。
	[ -u FILE ] 如果 FILE 存在且设置了SUID位时返回为真。
	[ -w FILE ] 如果 FILE 存在且是可写的则返回为真。（一个目录为了它的内容被访问必然是可执行的）
	[ -x FILE ] 如果 FILE 存在且是可执行的则返回为真。
	[ -O FILE ] 如果 FILE 存在且属有效用户ID则返回为真。
	[ -G FILE ] 如果 FILE 存在且默认组为当前组则返回为真。（只检查系统默认组）
	[ -L FILE ] 如果 FILE 存在且是一个符号连接则返回为真。
	[ -N FILE ] 如果 FILE 存在 and has been mod如果ied since it was last read则返回为真。
	[ -S FILE ] 如果 FILE 存在且是一个套接字则返回为真。
	[ FILE1 -nt FILE2 ] 如果 FILE1 比 FILE2 新, 或者 FILE1 存在但是 FILE2 不存在则返回为真。
	[ FILE1 -ot FILE2 ] 如果 FILE1 比 FILE2 老, 或者 FILE2 存在但是 FILE1 不存在则返回为真。
	[ FILE1 -ef FILE2 ] 如果 FILE1 和 FILE2 指向相同的设备和节点号则返回为真。

	字符串判断
	[ -z STRING ] 如果STRING的长度为零则返回为真，即空是真
	[ -n STRING ] 如果STRING的长度非零则返回为真，即非空是真
	[ STRING1 ]　 如果字符串不为空则返回为真,与-n类似
	[ STRING1 == STRING2 ] 如果两个字符串相同则返回为真
	[ STRING1 != STRING2 ] 如果字符串不相同则返回为真
	[ STRING1 < STRING2 ] 如果 STRING1字典排序在STRING2前面则返回为真。
	[ STRING1 > STRING2 ] 如果 STRING1字典排序在STRING2后面则返回为真

	数值判断
	[ INT1 -eq INT2 ] INT1和INT2两数相等返回为真 ,=
	[ INT1 -ne INT2 ] INT1和INT2两数不等返回为真 ,<>
	[ INT1 -gt INT2 ] INT1大于INT2返回为真 ,>
	[ INT1 -ge INT2 ] INT1大于等于INT2返回为真,>=
	[ INT1 -lt INT2 ] INT1小于INT2返回为真 ,<
	[ INT1 -le INT2 ] INT1小于等于INT2返回为真,<=

	逻辑判断
	[ ! EXPR ] 逻辑非，如果 EXPR 是false则返回为真。
	[ EXPR1 -a EXPR2 ] 逻辑与，如果 EXPR1 and EXPR2 全真则返回为真。
	[ EXPR1 -o EXPR2 ] 逻辑或，如果 EXPR1 或者 EXPR2 为真则返回为真。
	[ ] || [ ] 用OR来合并两个条件
	[ ] && [ ] 用AND来合并两个条件

	其他判断
	[ -t FD ] 如果文件描述符 FD （默认值为1）打开且指向一个终端则返回为真
	[ -o optionname ] 如果shell选项optionname开启则返回为真

	F高级特性：
	双圆括号(( ))：表示数学表达式
	双方括号[[ ]]：表示高级字符串处理函数，可以使用模式匹配和正则
	在shell中，[ \$a != 1 || \$b = 2 ]是不允许出，要用[ \$a != 1 ] || [ \$b = 2 ]，
	而双括号就可以解决这个问题的，[[ \$a != 1 || \$b = 2 ]]。又比如这个[ \"\$a\" -lt \"\$b\" ]，
	也可以改成双括号的形式((\"\$a\" < \"\$b\"))

	1：判断目录\$doiido是否存在，若不存在，则新建一个
	if [ ! -d \"\$doiido\"]; then
	　　mkdir \"\$doiido\"
	fi
	另一种写法
	[[ \"\$(whoami)\" != 'root*' ]] && ( echo \"You have no permission to run $0 as non-root user.\"; exit 1 )
	
	if 用法
	if [ \$1x == \"ab\"x ]; then
	    :
	elif [ \$1x == \"cd\"x ]; then
	        :  #:表示空语句
	else
		:
	fi
	";;
调试)
	echo "#https://blog.csdn.net/zhangna20151015/article/details/51539027
	shell脚本的调试，主要有4种：trap命令、tee命令、调试钩子和shell选项";;
for|open)
	echo "#1)##############
	for alpha in a b c d;do
	    echo \$alpha
	    done
	for i in \${#arr[@]} ; do echo  \$i \${arr[\$i]} done
	    
	    
	    list=\"a b c d\"
	for alpha in \$list;do
	    echo \$alpha
	    done
	#2)############
	for file in \$HOME/a/*;do
	    echo \$file
	    done
	
	for file in \$HOME/a/1.txt \$HOME/a/2.txt \$HOME/a/b;do
	    echo \$file
	    done
	
	for alpha in \`cat alpha.txt\`;do
	    echo \$alpha
	    done
	
	for (( i = 0; i < 10; i++ ));do
		#commands
	done
	
	while command;do
	　　#commands
	done
	 #while满足条件就执行循环
	until [ \$i -gt 100 ]
	do
	sum=\$((\$sum+\$i))
	i=\$((\$i+1))
	done
	#满足条件就不执行
	###########逐行读取###
	
	while read myline
	do
		echo \$myline
	done < datafile.txt
	##################
	cat datafile.txt | while read myline
	do
	 	echo \$myline
	done
	####################
	cat datafile.txt | while myline=\$(line);
	do
		echo \$myline
	done
	#####################
	while myline=\$(line)
	do
		echo \$myline
	done < datafile.txt
	";;
exit|return|break)
	exho "	exit 0 #正常运行程序并退出程序
	exit 1  #非正常运行导致退出程序
	#每一个 command 在结束时都会送回 return value 不管你跑什么样的命令
	#为 0 的值，因此也为 true 。非 0 的值，因此为 false 
	break n
	#这里n指定的第n个封闭的循环退出。
	#break语句用于终止整个循环的执行
	#continue语句break命令类似，但它会导致当前迭代的循环退出，而不是整个循环。
	";;

curl|wget)
	echo "# http://man.linuxde.net/curl
	curl -I -m 5 -s -w "%{http_code}\n" -o /dev/null   http://cui:8080/

	//判断网站返回码是否正常

	curl http://man.linuxde.net/text.iso --silent -O
	curl http://man.linuxde.net/test.iso -o filename.iso --progress       
	#静默模式--silent
	#把输出写到该文件中，保留远程文件的文件名 -O
	
	curl http://man.linuxde.net --cookie \"user=root;pass=123456\"
	#使用--cookie "COKKIES"选项来指定cookie，多个cookie使用分号分隔
	
	curl URL --cookie-jar cookie_file
	#将cookie另存为一个文件，使用--cookie-jar选项

	curl -u user:pwd http://man.linuxde.net
	使用curl选项 -u 可以完成HTTP或者FTP的认证，可以指定密码，也可以不指定密码在后续操作中输入密码

	curl -I http://man.linuxde.net
	通过-I或者-head可以只打印出HTTP头部信息

	curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
	curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com
	curl -T localfile -u name:passwd ftp://upload_site:port/path/           
	通过 -T 选项可将指定的本地文件上传到FTP服务器上   
	
	#curl模拟get和post请求 https://blog.csdn.net/russ44/article/details/53308838

	curl localhost:9999/api/daizhige/article -X POST -d "title=comewords&content=articleContent"
	如上，这就是一个普通的 post 请求。
	curl localhost:9999/api/daizhige/article -X POST -H "Content-Type:application/json"  \  #这里是换行
	-d '"title":"comewords","content":"articleContent"'
	# 接口测试 http://blog.sina.com.cn/s/blog_16591282a0102x93u.html
	curl -d "user=nickwolfe&password=12345" http://www.linuxidc.com/login.cgi
	curl localhost:8000/api/v1/upimg -F "file=@/Users/fungleo/Downloads/401.png" -H "token: 222" -v
	#get请求 ，如果想看到详细的请求信息，我们可以加上 -v 参数
	curl localhost:9999/api/daizhige/article
	curl localhost:9999/api/daizhige/article -v 
	
	wget –post-data 'user=foo&password=bar' http://www.baidu.com
	#curl模拟的访问请求一般直接在控制台显示，而wget则把结果保存为一个文件
	# http://www.cnblogs.com/analyzer/archive/2010/0   5/04/1727438.html
	";;
diff|comm|排序)
	echo " comm <(sort s) <(sort d) //s.d是文件
	-1   不显示只在第1个文件里出现过的列。
	-2   不显示只在第2个文件里出现过的列。
	-3   不显示只在第1和第2个文件里出现过的列。
	comm - 12     就只显示在两个文件中都存在的行；
	comm - 23    只显示在第一个文件中出现而未在第二个文件中出现的行；
	comm - 123  则什么也不显示。
	";;

date)
	echo "#d必须小写 
	date +%Y%M%d%H%M%S 
	#结果20180503140548
	####1.通过date命令获取，获取结果：0为星期日，1-6为星期一至星期六。
	#http://heylinux.com/archives/1296.html
	date +%w 取得当天是星期几
	date -d 20101211 +%w 取得2010年12月11日是星期几
	";;
sed)
	echo "seq 10 |sed -n \"/\$((5-3))/,+3p\"
	#5行的前3行包含5行
	seq 10 |sed -n '/5/,+3p' ";;
awk)
	echo "http://blog.itpub.net/24237320/viewspace-2124995/
	#OFS：列输出分隔符
	#\$NF: 最后一个列，输出最后一个列的内容
	#NR: 表示当前读取的行数
	#FNR:当前修改了多少行
	#NR 每行的记录号，多文件记录递增
	#FNR与NR类似，不过多文件记录不递增，每个文件都从1开始
	wget \`grep -Po '(?<=href=\")[^\"]+' qq.txt |grep ^c|awk '!a[\$0]++'|awk '{print \"http://www.666cmd.com/\"\$0}'\`
	" 
	;;

py)
	echo "	https://www.jb51.net/article/63592.htm
	split()：拆分字符串
	os.path.split()：按照路径将文件名和路径分割开
	u =\"www.doiido.com.cn\"
	print u.split('.')
	['www', 'doiido', 'com', 'cn']
	print u.split('.',1)
	['www', 'doiido.com.cn']
	print u.split('.',2)[1]
	doiido
	u1,u2,u3 = u.split('.',2)
	一、去除空格
	　　strip()
	\"   xyz   \".strip()            # returns 'xyz'  
	\"   xyz   \".lstrip()           # returns 'xyz   '  
	\"   xyz   \".rstrip()           # returns '   xyz'  
	\"  x y z  \".replace(' ', '')   # returns 'xyz'
	[  line.replace('\n', '')  for line in open("aa")]
	//结合split 获取文件指定列的数据
	list.index(aa)//返回下标
	list[-3:]
	list[:3]
	list[3:5]
	https://blog.csdn.net/xpresslink/article/details/77727507
	list1 = [3,5,-4,-1,0,-2,-6]
	print(sorted(list1, key=lambda x: abs(x)))
	Python提供了很多函数式编程的特性，如：map、reduce、filter、sorted等这些函数都支持函数作为参数
	lambda函数就可以应用在函数式编程中

	L = [(lambda x: x**2),(lambda x: x**3),(lambda x: x**4)]
	print (L[0](2),L[1](2),L[2](2))
	D = {'f1':(lambda: 2+3),'f2':(lambda: 2*3),'f3':(lambda: 2**3)}
	print D['f1'](),D['f2'](),D['f3']()
	print [x**2 for x in range(10)]
	print map((lambda x: x**2), range(10))
	python -c \"print ([x+y for x in range(5) if x%2 == 0 for y in range(10) if y%2 ==1])\"
	print [num for num in (x**2 for x in range(5))]
	print ([(i,j) for i in range(0,booksheet.nrows) for j in range(0,booksheet.ncols)  if  booksheet.cell(i,j).value==\"序号\"][-1])
	print ([{i:j} for i in range(0,booksheet.nrows) for j in range(0,booksheet.ncols)  if  booksheet.cell(i,j).value==\"序号\"][-1])
	print  ([ booksheet.cell(i,j).value for i in range(0,booksheet.nrows) for j in range(0,booksheet.ncols)  if  booksheet.cell(i,j).value==\"序号\"])

	
	"

	;;

perl)
	echo " perl -i -pe '\$_ =~ s/java.+tppabs=\"//' index.htm
	//替换java 到tppabs=\"之前的内容为空
	";;
termux|ubuntu|root)
	echo "	vim  \$PREFIX/etc/motd
	//修改欢迎

	ubuntu su认证失败，是因为没有设置root密码
	sudo passwd root 设置root密码即可
	##修改ubuntu欢迎界面提示语##
	cd /etc/update-motd.d/
	只保留00-header* 其余删除即可，可以在保留文件中添加cat信息
	";;
php)
	echo "php -S 127.0.0.1:8080 -t www/
	\$a=\"abcd\";
        \$b=\"efgh\";                                                                \$c=\$a.\$b; print (\$c); 则显示的是 abcdefgh
	";;
rename)
	echo "	rename .php .html  *.php
	//批量把php结尾的文件改为html结尾的
	";;
kill)
	echo "	killall nginx
	pkill nginx
	//按程序名杀
	fuser -k 8080/tcp 
	//按端口杀
	netstat -an |grep 8080 
	//查看指定端口
	";;
alias|as|a)
	echo "	alias -p  |grep pcurl
	//查看自定义alias
	";;

sql)	
	echo "###分组和聚合函数一起使用
	select prov_code ,count(prov_code) from STTL_CENTER_DATA where bill_code='D287' group by prov_code
	select prov_code ,count(prov_code)aa from STTL_CENTER_DATA group by prov_code having aa >12
	group by 不能和select * 一起使用

	HAVING语句通常与GROUP BY语句联合使用，用来过滤由GROUP BY语句返回的记录集.
	
	HAVING语句的存在弥补了WHERE关键字不能与聚合函数联合使用的不足。在这里，如果用WHERE代替HAVING就会出错
	###新增列字段
	 ALTER TABLE MONTHLY_SUB_COUNT_WORK ADD HM_CITY_CD VARCHAR2(5);
	 ALTER TABLE MONTHLY_SUB_COUNT_WORK ADD VSTD_CITY_CD VARCHAR2(5);

	删除列字段
	 alter table MONTHLY_SUB_COUNT_WORK drop column  HM_CITY_CD  ;
	 alter table MONTHLY_SUB_COUNT_WORK drop column  VSTD_CITY_CD  ;
	增加列注释
	comment on column MONTHLY_SUB_COUNT_WORK.hm_city_cd is '归属地市';
	";;
mysql)
	echo "	mysql -uroot -ptest123 -e\"create database wordpress;show databases;\"
	//创建数据库
	";;
git)
	echo "//git 提交远程仓库
	git remote -v
	//查看详细远程仓库信息
	git remote rm origin 
	//删除远程仓库
	git remote add origin https://username:password@github.com/cuiyubing819/myfirst.git
	//添加远程仓库
	
	##如果已设置远程仓库，提交本地文件到远程仓库只需下面三个步骤
	git add my
	//添加 my文件到仓库
	git commit –m \"描述信息\"
	//添加描述信息
	git push origin master 
	//提交文件到远程库
	
	http://www.runoob.com/git/git-server.html
	##创建私有仓库
	";;

samba|共享)
	echo "	sudo apt-get install samba 
	#sudo apt-get install smbclient
	//用于linux用户访问smb共享才需安装
	sudo vi /etc/samba/smb.conf
	在行尾追加如下内容
	[share]
	comment = Share Folder requirepassword
	browseable = yes
	path = /home/hello/share
	create mask = 0777
	directory mask = 0777
	valid users = hello
	force user = nobody
	force group = nogroup
	public = yes
	writable = yes
	available = yes
	
	//在hello用户下新建文件夹share，并赋权
	sudo mkdir share
	chmod 777 share
	samba restart
	//重启服务
	sudo smbpasswd -a hello
	//把hello用户添加到smb，回车提示输入smb密码，用于后续登陆

	在其他同局域网主机输入 \\192.168.43.7 可以看到共享文件夹share提示输入用户名密码
	#https://blog.csdn.net/u014159143/article/details/77044864
	";;
zip|加密)
	echo "	zip -P cyb123456 my.zip  my
	//-P 为大写字母，cyb123456为压缩密码，my.zip是压缩后的文件必须命名为zip后缀，my是需要压缩的文件
	zip -P cyb123456  my.zip 
	//解密解压,密码错误会报错
	";;
vlt)
	echo "	og 下发逻辑
	0是普通漫游话单 1是vpmn 2是亲情网
	亲情网主号必须是移动号码，公参以list形式存入在redis，其他公参是存在mcbdba公参表中
	主号判断逻辑：list的key和value是相同的号码就是家庭主号
	辅号判断： list的key和value不一致就是
	下发尾记录只统计0和1的话单，如果有2的话单就当作0的话单来处理
	开发人员找 麦钧博 52628713
	
	--根据省份找生成号码
	select t.imsi_area_id,t.msisdn_area_id,t.ld_area_cd,t.imsi_type ,rownum  from mcbdba.IMSI_LD_CD t where t.LD_AREA_CD in 
	(select ld_area_cd from mcbdba.DOM_LD_AREA_CD_PROV t where t.PROV_CD='&nu' )
	and t.effc_tm<sysdate and  t.imsi_type=1 and t.expired_tm>sysdate and rownum<6  ;
	select t.ld_area_cd,t.msisdn_area_id,t.carrier_type ,rownum  from mcbdba.UNICOM_MSISDN_LD_CD t where t.LD_AREA_CD in
	(select ld_area_cd from mcbdba.DOM_LD_AREA_CD_PROV t where t.PROV_CD='&nu' )
	and t.effc_tm<sysdate and t.expired_tm>sysdate and t.carrier_type=01 and rownum<6  ;
	select t.ld_area_cd,t.msisdn_area_id,t.carrier_type ,rownum  from mcbdba.UNICOM_MSISDN_LD_CD t where t.LD_AREA_CD in
	(select ld_area_cd from mcbdba.DOM_LD_AREA_CD_PROV t where t.PROV_CD='&nu' )
	and t.effc_tm<sysdate and t.expired_tm>sysdate and t.carrier_type=02 and rownum<6  ;
	select m.swch_area_id,m.ld_area_cd,m.vt_flag,m.effc_tm,m.expired_tm,rownum  from mcbdba.SWCH_ID_LD_CD m where m.ld_area_cd in
	(select t.ld_area_cd from mcbdba.dom_ld_area_cd_prov t where t.prov_cd='&nu' and t.effc_tm<sysdate and t.expired_tm>sysdate )
	and m.effc_tm<sysdate and m.expired_tm>sysdate and rownum < 10;

	--公参修改
	其中dom_ld_area_cd_prov_ext，idd_cd，DOM_NUM_PREFIX，DOM_SP_RATE_INFO，imsi_ld_cd，dom_ld_area_cd_prov_ext，
	BR_MSC_COVER_AREA_CD，swch_id_ld_cd，unicom_msisdn_ld_cd，dom_ld_area_cd_prov_ext，swch_id_ld_cd_vt这些表参与修改


		";;
test|报表)
	echo "报表全国省份汇总，业务方杨(48652768)，开发李健(344989306)
	supdba/supdba@CPS1_192_168_70_11
	select t.*, t.rowid from STTL_CENTER_DATA t where t.bill_code='D259' and prov_code in(571)
	//入库表
		
		
	";;
scp)
	echo "##上传到远端
	1、上传目录：
	scp -r   ./util   root@192.168.1.65:/home/wwwroot/limesurvey_back/scp
	2、上传文件
	scp   ./util   root@192.168.1.65:/home/wwwroot/scp 
	##远端下载:
	scp  -r   root@211.154.xxx.xxx:/share/webCompileOut.sql  ./
	##如果是目录拷贝要加“-r”参数，用户名可选，如果省略用户名，默认为终端的用户名。
	";;
正则)
	echo "	https://www.jb51.net/article/80187.htm
	";;
随机|shuf|eval)
	echo "a=(\"aa\" \"bb\" \"cc\" \"mm\");echo \${a[\$( seq  \$(expr \${#a[@]} - 0) |shuf -n1 )]}
 
	";;
关机)
	echo "	重启命令
	reboot
	shutdown -r now 立刻重启
	shutdown -r 10 过10分钟自动重启
	shutdown -r 20:35 在时间为20:35时候重启
	shutdown -c 取消重启
	关机命令
	halt
	poweroff 立刻关机
	shutdown -h now 立刻关机
	shutdown -h 10 10分钟后自动关机
	";;
mount)
	echo "	//ubuntu挂载sata硬盘
	##https://yq.aliyun.com/articles/601273 参考文章
	先取消挂载目录
	1 找到sata磁盘 fdisk -l
	2 删除/dev/sdb所有分区 和创建分区
	fdisk /dev/sdb
	
	Command(m for help): n(回车新建分区)
	p primary partition(1-4): p(回车新建主分区)
	Partition number (1-4): 1(分区号1-4之间选择1)
	First cylinder(2048-xxxxx,default 2048):(开始柱面 回车默认选择最小值)
	Last cylinder(2048-xxxxx,default xxxxx):(结束柱面 选择上一步中的xxxxx)
	Command(m for help): p(查看调整后分区表)
	Command(m for help): w(回车保存新的分区)
	
	3 格式化磁盘 mkfs.ext4 /dev/sdb1
	（之前没有操作第三步导致挂载了只有400m，如果有挂载先取消挂载才能格式化成功）
	4 挂载 mount /dev/sdb1 /home/mysata
	此时df -h便可以便可以看到挂载的sata磁盘的目录mysata
	5 fuser -k /home/mysata
	fuser -k /dev/sdb1
	umount /file1
	umount /dev/sdb1
	取消占用和取消挂载
	";;
古炎|vlt地市改造)
	echo "	--volte 地市
	
	delete from vltdba.sttl_city_daily_work_test;
	commit;
	
	--测试 qb_vlt_city_sttl_d 存储过程  预期数据生成 
	--输入：
	select * from vltdba.pre_merge_cdr_vlt_hm_200; 
	--输出：
	select * from vltdba.sttl_city_daily_work

	create table vltdba.sttl_city_daily_work_test
	as select * from vltdba.sttl_city_daily_work where 1=2 ;
	insert into  vltdba.sttl_city_daily_work_test(select *from 
	(select '20180911', HM_CITY_CD,VSTD_CITY_CD,count(HM_CITY_CD)  ,sum(HM_RM_CHG), '1' from vltdba.pre_merge_cdr_vlt_hm_200  where IN_FLAG=1 and STTL_DT =20180911 
	group by HM_CITY_CD ,VSTD_CITY_CD  )union all
	(select '20180911', HM_CITY_CD,VSTD_CITY_CD,count(HM_CITY_CD)  ,sum(HM_RM_CHG), '0' from vltdba.pre_merge_cdr_vlt_hm_200  where IN_FLAG=0 and STTL_DT =20180911 
	group by HM_CITY_CD , VSTD_CITY_CD )union all
	(select '20180911', HM_CITY_CD, VSTD_CITY_CD,count(HM_CITY_CD)  ,sum(HM_RM_CHG), '2' from vltdba.pre_merge_cdr_vlt_hm_200  where IN_FLAG=2 and STTL_DT =20180911 
	group by HM_CITY_CD , VSTD_CITY_CD) 
	  );
	  commit;
	
	##测试预期数据和实际数据比对，为空则为一致
	  select * from (select * from vltdba.sttl_city_daily_work_test order by HM_CITY_CD , CDR_COUNT) minus 
	  select * from (select * from vltdba.sttl_city_daily_work order by HM_CITY_CD , CDR_COUNT);
	--测试 qb_vlt_city_count_m存储过程 
	--输入表 vltdba.monthly_sub_count_work
	--输出表 vltdba.monthly_sub_count_work;

	";;
split|wc|切割)
	echo "	wc -c 查字符串
	split -b 100m 1111.log (按照字节分隔)
	split -l 1000000 1111.log(按照行数分隔)
	";;
dblink)
	echo "##创建dblink
	create public database link testvlt2 connect to vltdba identified by HyxtTest_9
	　　 using '(DESCRIPTION =
	(ADDRESS_LIST =
	(ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.117.223)(PORT = 1521))
	)
	(CONNECT_DATA =
	(SERVICE_NAME =gps)
	)
	)';
	##插入数据dblink
	insert into  monthly_sub_count_work(MONTH,IMSI_MIN,VSTD_PROV_CD,HM_PROV_CD,DB_INSR_DT,BUSINESS_TYPE)
	select MONTH,IMSI_MIN,VSTD_PROV_CD,HM_PROV_CD,DB_INSR_DT,BUSINESS_TYPE from vltdba.monthly_sub_count_work@testvlt2 where  to_char(month,'yyyymmdd')=20180901;
	";;	

vlt_og)
	echo "	update  vltdba.og_fms_proc_state_volte set PROC_TM=to_date('2018/9/10 3:15:00','yyyy-MM-dd HH24:mi:ss')， OG_START_DT=20180910,SEQNUM=13
	
	select  t.job_title,t.description ,t.state,t.cron_expr,t.fixed_param,t.update_flag from vltfrontdba.qrtz_conf t
	where t.job_title like 'OggenVsJob_%' or  t.job_title like 'OggenVs_%' or  t.job_title like 'OggenFMS_%';
	
	update  vltfrontdba.qrtz_conf t  set  t.state=1, t.update_flag=1
	where t.job_title like 'OggenVsJob_%' or  t.job_title like 'OggenVs_%' or  t.job_title like 'OggenFMS_%';
	
	";;

redis)
	echo "##连接
	redis-cli -c  -h 192.168.117.245 -p 7008 -a abc123
	##查询list
	echo \"LRANGE B1216006.451_VL_ERR  0 -1\" | redis-cli -h 192.168.117.245 -p 7008 -a abc123  >key
	##插入list,在集群环境要加-c参数不然报错
	echo \"rpush 13484099263 1||13484099263||20180921150002||20991231235959\"| redis-cli -c  -h 192.168.117.245 -p 7008 -a abc123

	";;
todo)
	echo "#待处理知识点
	https://blog.csdn.net/zcywell/article/details/7258049
	IS TABLE OF 
	路由固件刷潘多拉包
	刷了openwrt就相当于一个linux系统带无线带多网卡的电脑
	";;
plsql)
	echo "#plsql代码片段#http://www.cnblogs.com/hans_gis/p/5632889.html
	declare
	type num_list is varray(31) of varchar2(8);
	xz num_list := num_list(100,200,210,220,230,240,250,270,280,290,311,351,371,431,451,471,531,551,571,591,731,771,791,851,871,891,898,931,951,971,991);
	begin
	for i in 1..xz.count
		loop
		     execute immediate 'truncate table pre_merge_cdr_vlt_hm_'||xz(i);
		     dbms_output.put_line('truncate table pre_merge_cdr_vlt_hm_'||xz(i) );
	     end loop;
     	end;
	

	";;
vltconf|path|parameter)
	echo "	异步入库AsynLoadDbVlt备份目录
	/opt/mcb/vlt/arch/backup_cdr/571
	-C普通漫游  -B 边漫 -L 本地
	亲情网在公参在redis中存储，家庭主号是归属号码并且是移动号码，副号是被叫号码 判断是否为亲情网 如果是znw vpmn话单不做亲情网号码判定直接归为znw话单
	‘如果不是亲情网话单，看归属号码的 在redis list中是否存在，存在的看values 是否主叫号码，看被叫号码在 redis list能找到，看values是不是主叫号码，
	如果满足条件看生失效时间。
	疑问：上面的号码生效情况把主被叫号码颠倒换置 的情况属不属于亲情网号码
	
	select *from  monthly_sub_count_work t where to_char(t.month,'yyyymmdd')=20180901 
	异步入库会入这个张表，单这张表没有唯一主键或索引会有重复数据
	
	vlt 地市结算
	STTL_CITY_SUBCOUNT_MONTHLY   ---vot2库
	STTL_CITY_DAILY_WORK  ----vot1库
	STTL_CITY_MONTHLY      ----vot1库
	qb_vlt_city_count_m - vlt12
	qb_vlt_city_sttl_d - vlt11
	qb_vlt_city_sttl_m - vlt1


	";;
crontab)
	echo "##
	实例1：每1分钟执行一次command
	命令：
	* * * * * command
	实例2：每小时的第3和第15分钟执行
	命令：
	3,15 * * * * command
	实例3：在上午8点到11点的第3和第15分钟执行
	命令：
	3,15 8-11 * * * command
	实例4：每隔两天的上午8点到11点的第3和第15分钟执行
	命令：
	3,15 8-11 */2 * * command
	实例5：每个星期一的上午8点到11点的第3和第15分钟执行
	命令：
	3,15 8-11 * * 1 command
	实例6：每晚的21:30重启smb
	命令：
	30 21 * * * /etc/init.d/smb restart
	实例7：每月1、10、22日的4 : 45重启smb
	命令：
	45 4 1,10,22 * * /etc/init.d/smb restart
	实例8：每周六、周日的1 : 10重启smb
	命令：
	10 1 * * 6,0 /etc/init.d/smb restart
	实例9：每天18 : 00至23 : 00之间每隔30分钟重启smb
	命令：
	0,30 18-23 * * * /etc/init.d/smb restart
	实例10：每星期六的晚上11 : 00 pm重启smb
	命令：
	0 23 * * 6 /etc/init.d/smb restart
	实例11：每一小时重启smb
	命令：
	* */1 * * * /etc/init.d/smb restart
	实例12：晚上11点到早上7点之间，每隔一小时重启smb
	命令：
	* 23-7/1 * * * /etc/init.d/smb restart
	实例13：每月的4号与每周一到周三的11点重启smb
	命令：
	0 11 4 * mon-wed /etc/init.d/smb restart
	实例14：一月一号的4点重启smb
	命令：
	0 4 1 jan * /etc/init.d/smb restart
	实例15：每小时执行/etc/cron.hourly目录内的脚本
	命令：
	01 * * * * root run-parts /etc/cron.hourly
	";;

分区字段修改)
	echo "##
	alter table  npsdba.og_file_audit  enable row movement
	然后update即可
	
	";;
公参增量加载)
	echo "##由于公参量比较大，会有全量公参和增量公参加载，增量加载是只加载部分满足条件的公参
	比如生效时间，一般解码程序会凌晨自动加载一次公参，把凌晨之前生效的公参全部加载的内存中，
	和通话时间进行比对是否满足条件，
	如果满足生失效时间的有效公参的 生效公参在凌晨以后就会加载不到，也就是话单的通话时间在2点，生效时间在
	1点，这条公参是加载不到的，第二天才能加载到，就有肯能被系统判为错单，目前公参加载延长了公参加载的时间为7天，
	本来加载不到的公参就可以加载到，就解决了系统因增量加载导致一些加载不到的有效公参不会被系统误判为错单的情况
	
	";;
存储过程)
	echo "## https://blog.csdn.net/leshami/article/details/17348067
	oracle 读取文件
	ho ls 可以sqlplus中使用linux 命令
	#https://blog.csdn.net/drbing/article/details/51821262
	Oracle存储过程给变量赋值的方法

	## ORACLE 存储过程INTO 多个变量
	select f1,f2,f3 into v1,v2,v3 from tab1
	##https://www.jb51.net/article/116017.htm
	多个存储过程的调用
	
	##带输入输出参数（如果不指明是输入或输出就按输入来）
	create procedure procedure_3(v_i in number,v_j in number ,v_m out number)
	is
	begin
	dbms_output.put_line('procedure_3.......');
	v_m:=v_i - v_j;
	dbms_output.put_line(v_i||' - '||v_j||' = '||v_m);
	end;
	
	##不带参数的 
	CREATE OR REPLACE PROCEDURE getDeptCount
	AS | IS
	deptCount int;
	BEGIN
	SELECT COUNT(*) INTO deptCount FROM dept;
	DBMS_OUTPUT.PUT_LINE('dept表共有'||deptCount||'行记录');
	END
	##调用过程

	declare
	v_param1 number(5):=2;
	v_param2 number(5):=8;
	v_result number(5);
	begin
	--调用上面案例一的存储过程
	procedure_1(); 
	--调用上面案例二的存储过程
	procedure_2(v_param1,v_param2); 
	--调用上面案例三的存储过程
	procedure_3(v_param1,v_param2,v_result);
	dbms_output.put_line(v_result);
	end;
	";;


按步长切割为数组)
	echo "##
	awk -vFIELDWIDTHS=\"1  4 5\"  'NF=NF' <<< abcdefghigh  
	## <<<	相当于 echo xxx |
	https://www.cnblogs.com/irockcode/p/7727641.html
	awk -vFIELDWIDTHS=\"1 2 3 4 5\" -vOFS=\"|\" 'NF=NF' file
	awk -vFIELDWIDTHS=\"2 3 10\" 'NF+=0' <<< abcdefghigh 

	https://blog.csdn.net/mingyuli/article/details/81604795?utm_source=blogxgwz0
	##python 中的[:-1]和[::-1]

	a=\" aaa  \";echo $a'ss'|sed 's/ *//g'	
	";;
utf-8转换)
	echo "vim 中
	:set fileencoding=utf-8
	转换为utf-8
	:set fileencoding
	查看编码格式
	
	";;
shell打包)
	echo "##http://bbs.chinaunix.net/thread-4245700-1-1.html
	
	";;

vbox)
	echo "##设置虚拟机ip
	/etc/sysconfig/network-scripts
	##cat ifcfg-enp0s8 内容如下
	TYPE=Ethernet
	PROXY_METHOD=none
	BROWSER_ONLY=no
	BOOTPROTO=static
	DEFROUTE=yes
	IPV4_FAILURE_FATAL=no
	IPV6INIT=yes
	IPV6_AUTOCONF=yes
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	IPV6_ADDR_GEN_MODE=stable-privacy
	NAME=enp0s8
	UUID=92cce637-86b1-4b5f-9a8c-98060a0b4fa1
	DEVICE=enp0s8
	ONBOOT=yes
	IPADDR=192.168.56.156
	NETMASK=255.255.0.0
	
	";;
sublime)
	echo "##sublime 删除插件 ctr+shift+p 输入remove 即可弹出删插件
	## 如果菜单栏不见 输入view即可显示
	
	";;
oracle)
	echo "##克隆安装oracle
	##参考https://www.cnblogs.com/chinesern/p/8393535.html
	##https://www.cnblogs.com/nucdy/p/5603998.html
	

	##安装oracle修改系统前置工作

	vim /etc/sysctl.conf
	##添加如下内容
	net.ipv4.icmp_echo_ignore_broadcasts = 1
	net.ipv4.conf.all.rp_filter = 1
	fs.file-max = 6815744 #设置最大打开文件数
	fs.aio-max-nr = 1048576
	kernel.shmall = 2097152 #共享内存的总量，8G内存设置：2097152*4k/1024/1024
	kernel.shmmax = 2147483648 #最大共享内存的段大小
	kernel.shmmni = 4096 #整个系统共享内存端的最大数
	kernel.sem = 250 32000 100 128
	net.ipv4.ip_local_port_range = 9000 65500 #可使用的IPv4端口范围
	net.core.rmem_default = 262144
	net.core.rmem_max= 4194304
	net.core.wmem_default= 262144
	net.core.wmem_max= 1048576
	
	vim /etc/security/limits.conf
	##添加如下内容
	oracle soft nproc  2047
	oracle hard nproc  16384
	oracle soft nofile 1024
	oracle hard nofile 65536
	oracle hard stack 10240
	##添加oracle 用户
	##添加dba组
	groupadd dba
	##添加oracle 用户
	useradd oracle
	##把oracle添加到dba组
	usermod -g dba oracle
	##设置oracle用户密码
	passwd oracle
	
	##创建克隆oracle目录的根目录
	mkdir -p /u01/
	
	##将文件的属主改为Oracle，属组改为dba
	chown -R oracle:dba /u01/
	
	##修改文件的访问权限为777（4+2+1,4+2+1,4+2+1）
	chmod -R 777 /u01/
	##把目标目录oracle用户目录的app打包
	tar -zcvf app.tar.gz app
	##vbox 挂载share共享到/mnt ，把app的gz包拷贝到共享
	mount.vboxsf share /mnt/
	##拷贝app.gz到克隆机的 /u01目录并解压
	tar -zxvf app.tar.gz
	##切换oracle目录设置环境变量
	su oracle
	vim .bash_profle ##添加oracle环境变量
	export ORACLE_BASE=/u01/app/oracle/ #oracle数据库安装目录
	export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/dbhome_1/ #oracle数据库路径
	export ORACLE_SID=orcl #oracle启动数据库实例名
	export ORACLE_TERM=xterm #xterm窗口模式安装
	export PATH=\$ORACLE_HOME/bin:/usr/sbin:\$PATH #添加系统环境变量
	export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib #添加系统环境变量
	export LANG=en_US.UTF-8 #防止安装过程出现乱码
	export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK  #设置Oracle客户端字符集，必须与Oracle安装时设置的字符集保持一致
	##生效环境变量
	source .bash_profle
	##删除oracle之前的产品信息
	cd /u01/app/oraInventory/ContentsXML
	vim inventory.xml ##删除 <HOME_LIST> 节点的<HOME ****/>的内容
	###如果不删除，后面的clone脚本会报错

	##执行克隆脚本
	cd /u01/app/oracle/product/11.2.0/dbhome_1/clone/bin
	perl clone.pl ORACLE_BASE=\$ORACLE_BASE ORACLE_HOME=\$ORACLE_HOME  ORACLE_HOME_NAME=OraDb11g_home1
	###执行完克隆操作，退出oracle用户，用root用户执行下面脚本
	sh /u01/app/oracle/product/11.2.0/dbhome_1/root.sh
	
	lsnrctl status/reload/start ## 切换oracle 用户 lsnrctl start 启动监听
	##如果启动报没有命令是因为环境变量没设置好
	
	##进入cli
	sqlplus / as sysdba
	SQL>startup; #启动数据库
	##如果报 ORA-01261: Parameter db_recovery_file_dest destination string cannot be translated
	SQL>startup mount pfile='/u01/app/oracle/admin/orcl/pfile/init.ora';
	###参考https://blog.csdn.net/ghost241/article/details/6955817
	##设置后在sql cli中关闭数据库
	SQL>shutdown immediate;
	SQL>startup;
	
	##修复默认scott用户密码
	status
    
	alter user scott account unlock;
	alter user scott identified by 123123;

	#####################克隆安装oracle坑指南####################################################
	1、【一定要和被克隆的机器目录保持一致，不要改变目录，改变目录安装你会死的很惨。不信可以尝试】
	2、设置环境变量，和系统配置，创建oracle用户即可，文件只需复制黏贴
	3、1和2搞完，只需启动监听，sqlplus / as sysdba 再start up 即可完成，就这么简单
	4、重要的事情说三遍，
	一定要和被克隆的机器目录保持一致 
	一定要和被克隆的机器目录保持一致 
	一定要和被克隆的机器目录保持一致
	##############################################################################################



		";;
bashrc)
	echo "
	cp  /etc/skel/.bashrc   ~/
	";;



help|h|-h)
 	echo "my + 关键词 //下面的是关键词"
	sed -n '/^\t/!p' $(basename $0) |sed -n '/^$/!p'|perl  -lne 'print unless /^\s/' |sed 's/)//g'|sed 's/\\//g'|sed 's/|/\n/g'|tr "\n"  ",";echo
	;;
 esac
