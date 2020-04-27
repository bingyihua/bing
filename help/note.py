#!/usr/bin/python
# -*- coding: UTF-8 -*-
import math
class testclass():
    def test(list):
        str_len=max([ len(i) for i in list ])
        #获取list中元素最大长度
        for m  in range(str_len):
            for i in [n[:(m+1)] for n in list  ]:
                if   len(i) <= str_len and  [n[:(m+1)] for n in list  ].count(i) >1 and  i.islower():
                    #重复元素大于1且是小写
                    str_num=[n[:(m+1)] for n in list  ].count(i)
                    #前缀字符重复最大个数
                    str=i
                    #前缀字符重复的字符串
                    #break
                elif   len(i) ==1  and  [n[:(m+1)] for n in list  ].count(i) ==1:
                    str_num=0; str=""
        return  str_num,str
#if __name__ =='__main__':
reslut01 = testclass.test(["flowe","flew","flow","Flight","Fligh"])
reslut02 = testclass.test(["dog","racecar","car"])
print(reslut01)
print(reslut02)
s="ab,cde" 
print(s.upper()) #大写
print(s.lower()) #小写
print (s.title())#将给定的字符串中所有单词的首字母大写，其他全部小写
print (s.capitalize())#将给定的字符串中首字母大写，其他小写
print (s.swapcase())#把原来大写的改为小写，原来小写的改成大写
print (s.isdecimal())#判断字符串是否是纯数字
print (s.isalpha())#判断字符串是否是字母
print (s.isalnum())#判读是否只包含数字和字母
print (s.isupper())#判断是否全是大写
print (s.islower())#判断是否全是小写
print (s.istitle())#判断是否符合title
print (s.isspace())#判断是否是为空格，换行或制表符
print (s.isprintable())#判断是否为可打印字符（只有空格可以，换行、制表符都不可以）
#isidentifier():判断给定的字符串是否符合命名规则（只能是字母或下划线开头、不能包含除数字、字母和下划线以外的任意字符。）
print("qwer".ljust(10,"+")) #左居填充
print("qwer".rjust(10,"+")) #右居填充
print("qwer".center(10,"+")) 
# 不加"+""-"纯数字，用填充物"0"将字符串前填充满
print("12345".zfill(10))
# 加"-"纯数字，越过"-"用填充物"0"将字符串前填充满
print("-125".zfill(10))
# 加"+"数字字母组合，越过"+"用填充物"0"将字符串前填充满
print("+qwe125".zfill(10))
# 加其他符号，用填充物"0"将字符串前填充满
print("#qwe12".zfill(10))

# 全部字符串内 搜索qwe 出现的次数
print("qwertasdqwezxcqwe".count("qwe"))
# 由于字符串从0开始计数，1为字符串第二个，相当于从w开始
print("qwertasdqwezxcqwe".count("qwe",1))
# 从字符串第 2个开始到第15个截止，共出现qwe的次数
print("qwertasdqwezxcqwe".count("qwe",1,14))

# 搜索开头位置为qwe 符合条件，为True 
print("qwertasdqwezxcqwe".startswith("qwe"))
# 开头位置为字符串下标为1开始，也就是说开头为wer与qwe不同为False
print("qwertasdqwezxcqwe".startswith("qwe",1))
# 结尾位置为qwe符合条件 为True
print("qwertasdqwezxcqwe".endswith("qwe"))

s="qweraqwesfgzqweop"
print(s.find("qwe"))#左边查找qwe 找到第一个返回其下标
print(s.find("qwe",2))#左边查找qwe找到第2个返回其下标
print(s.rfind("qwe"))#右边查找qwe 找到第一个返回其下标
print(s.rfind("qwe",2))
print(s.index("qwe"))#默认左边找到第一个返回其下标
print(s.rindex("qwe"))
#以上情况均为找到对应子字符串，若未找到,运行结果：find返回-1  index报错，情况如下

s="qweraqwesfgzqweop"
# 将字符串全部的qwe  换为asd
print(s.replace("qwe","asd"))
# 将字符串前两个qwe  换为asd
print(s.replace("qwe","asd",2))
# 将字符串全部的qew  换为asd 没有则输出原字符串
print(s.replace("qew","asd"))

t="qwe\tqwer\tqasdsdf\tas"
print(t.expandtabs(4)) 

t="qwer,tyuas,dfghjkl"
print(t.partition("yua"))
print(t.partition("asqw"))
print(t.rpartition("asqw"))

m=t.split(",")
print(m)

#字符串类型
a="qwer"
print("_".join(a))

#元组类型
b=("a","b","c","d")
print("=".join(b))

#集合类型
c={"qwe","asd","zxc"}
print(" ".join(c))

a="    qweasdzxcrtqwe    "
print(a.strip())
b="qweasdzxcrtqwe    "
print(b.lstrip('q'))
c="   qweasdzxcrtqwe"
print(c.rstrip('qew'))
print (len("ssss")) 

seq = ('Google', 'Runoob', 'Taobao')
dict = dict.fromkeys(seq)
print  (dict) 
dict = dict.fromkeys(seq,10)
print   (dict)

dict1 = {'Name':'Zara', 'Age':27}
print   (dict1.get('Age'))
print   (dict1.get('Sex', "Never"))

for k,v in  dict1.items():
    print(k,v)
aa=[13,33,767,55]
bb=["dog","aacecar","car"]
a = [3,1,4,6]
a.sort()
bb.sort()
print(a,bb)
a = [['5.1.5.40580', 29], ['5.0.8.14000', 11], ['5.0.8.14999', 59], ['5.1.4.37882', 4]]
a.sort(key=lambda x:x[1],reverse=True)
print(a)
#key=lambda x:x[1]：按照数组索引1列进行排序，无此参数默认以0列进行排序
#reverse=True：倒序，无此参数默认升序
aList = [123, 'xyz', 'zara', 'abc'];
aList.append( 2009 );
aList.insert( 3, 2009)
print ( aList,aList.index(123))
aList.reverse()
print ( aList,  max(["234","wwww"]),len(["234","wwww"]))
import operator
print (operator.lt("s", "s"))
print (operator.eq(["s"], ["s"]))
#lt(a,b)   表示  a<b :从第一个数字或字母（ASCII）比大小 
#le(a,b)   表示  a<=b
#eq(a,b)   表示  a==b 字母完全一样，返回True,
#ne(a,b)   表示  a!=b
#gt(a,b)   表示  a>b
#ge(a,b)   表示  a>=b
set1 ={1, 2, 3}
set2 =set([2, 3, 4]) #集合对象只要集合对象支持集合运算，空字典是{}, 元祖是()理解为只读list
print (type(set1))
"""
&: 交集
|: 并集 
-: 差集
^: 对称差集
"""
print(list(set1 & set2))
print (eval("2+3"),eval("pow(100, 2)"),eval("math.sqrt(100)"))
aa="aaa"
print (repr("aaa"),repr(aa))
print (3 in [1, 2, 3])
aa=["1","2","3"]
aa.reverse()#反序列数组
print([1,2,3],aa)
x=2;y=3;z=4
a=(x if (x>y) else y)
print(a if (a>z) else z)
a=lambda x:x*x
print(a(3))
p = lambda x,y:x+y
print(p(4,6))
a = lambda x,y,z:(x+8)*y-z
print(a(5,6,8))# :前面是参数，后面是参数的表达式有点像二元一次方程
def foo():
    print("starting...")
    while True:
        res = yield 4
        print("res:",res)
g = foo()
print(next(g))
print("*"*20)
print(next(g))

def myrange(stop):
	start = 0
	while start<stop:
		yield start
		start += 1
for i in myrange(10):
	print(i)

