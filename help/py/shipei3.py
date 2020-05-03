# def b():
#     print "aaa"
# ans = dict(dog=123, cat="bigcat")
#print a.__name__,ans
import os
f = open("123.txt")
line=f.readlines()
print line[1][0:3]
print len(line)
for i in range(len(line)-1): 
    if i>0:
        a=line[i]
        chuli[a]

def chuli(a):
    def f10(a):
        pass
        if true:
            pass
        else:
            paxsuzu.append(f10.__name__)
    f10(a)
    .....
    .....
    def paixu():
        



d = {'a':1,'b':4,'c':2}
字典是这个，然后要对字典按照value进行排序
方法一：
sorted(d.items(),key = lambda x:x[1],reverse = True)
方法二：
import operator
sorted(d.items(),key = operator.itemgetter(1))
方法三：
f = zip(d.values(),d.keys())
sorted(f)
//结果是 [(1, 'a'), (2, 'c'), (4, 'b')]
zip 之后，zip函数默认会对第一个元素进行排序的，如何取消排序？
