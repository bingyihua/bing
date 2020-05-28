#可以把/替换成其他特殊字符
echo 'hello, tony' | sed 's:tony:jack:'
echo '123 abc' | sed -r 's/[1-9]+/& &/' 
#&可以引用前面匹配的内容
#putout: 123 123 abc
echo 'hello, tony jack' | sed -r 's/([a-z]+) ([a-z]+)/\2 \1/'
#利用分组(\1, \2, ... , \9)   putout:  hello, jack tony
echo 'hello, tony tony yes ok ok' | sed -r 's/([a-z]+) \1/\1/g'
#putout:  hello, tony yes ok

echo 'hello world haha!' | sed 's/[a-z][a-z]*/T/2g'
#输出: hello T T!. 可以看到, 现在是替换了从第2个开始的所有单词(由小写的a~z组成的单词).

printf 'my name is\nhaha, jack\n' | sed 's/my/your/p'
# 输出
# your name is
# your name is
# haha, jack
printf 'my name is\nhaha, jack\n' | sed -n 's/my/your/p'
#your name is这行输出了两次, 一次是sed命令自动输出, 另一次是标识p影响的作用. 如果我们现在只想打印匹配的行, 不要自动输出所有的行, 可以用-n

echo 'hello, tony' | sed 's/Tony/jack/I'
#如果后面不加I标识, 则不会匹配成功.

sed '1 s/hello/byby/' test.txt
#s替换命令只会在第一行生效
sed '/^[0-9][0-9]*/ s/hello/byby/' test.txt 
#只有那些符合指定正则模式匹配的行才会处理

sed '10,20 s/hello/byby/' test.txt
## 处理第10行到第20行之间的数据

sed '10,$ s/hello/byby/' test.txt 
#处理第10到最后一行的所有数据

sed '/start/,/end/ s/hello/byby/' test.txt 
#从start开始处理, 到end结束.

sed '2,10 d' test.txt
#删除第2行到第三行之间的所有行

sed -e 's/#.*//' -e 's/[ ^I]//' -e '/^$/ d'  test.txt
#s/#.*//是把所有由#开头的内容去掉, 但是如果#前面有空格(space or tab), 就要做第二个命令处理: s/[ ^I]//, 就是把所有的空格去掉, 注意的是^I就是表示Tab. 最后一个命令就是所有空行(空行有两个来源, 一是文件本身的空行, 二是通过前面两条命令产生的空行)都通过命令d删除.

sed -n '1,10 p'
sed -n '11,$ !p'
sed '1,10 !d'
sed '11,$ d'
#!可以置反命令操作, 比如!d就是不删除的意思

sed '11 q' test.txt
#遇到满足条件时退出流编辑操作，只打印到第10行. 到第11行时就会退出. 

echo "to
tom aaa bbbtomaaa
111 tom aaaTOm cccc
aaaatomaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaatom
aaaa tom123 bbbbbb cccc
vvvv tom123457894 dddd
tooooooooooom fffff
tttttom rrrr
gggg tom1 y
jjjj kkkk lllll
ggggggggggggggggg
0000000000000000" > a
sed -n '/tom/d;p'  a
#删除tom所在的行

删除tom开头tom结尾的行
sed -n '/^tom/,/tom$/d;p' a

sed -n '/\<to/d;p' a
#删除单词有to开头的行 

sed -n '/om\>/d;p' a
#删除是om结尾的行

sed -n '/\<tom\>/d;p' a 
#删除有tom这个单词的行

sed '/tom/,$d' a 
#从tom 到最后一行之间的内容删除

sed 's/tom/TOM/2' a 
#替换第二个tom 标签是几就操作第几个字符

sed '3,7{s/tom/TOM/;s/[0-9]/wwww/g}' a 
#首先指定范围3-7行然后在大括号里执行多条命令

sed -n '3 s/tom/t\Uaaaaaaaaaaa/gp' a
#111 tAAAAAAAAAAA aaaTOm cccc \U 把U后面的值全部换成大写

sed -n '3 s/tom/t\uaaaaaaaaaaa/gp' a
#111 tAaaaaaaaaaa aaaTOm cccc \u 后面第一个换成大写

sed -n '3 s/tom/t\LAAAAAAAAAAA/gp' a
#111 taaaaaaaaaaa aaaTOm cccc \L 把后面大写的全部换成小写
sed -n '3 s/tom/t\lAAAAAAAAAAA/gp' a
#111 taAAAAAAAAAA aaaTOm cccc \l只替换第一个

sed -n '/root/r /etc/hosts' passwd 
#r将文件读取到匹配行的后面



