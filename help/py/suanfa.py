#!/usr/bin/python
# -*- coding: UTF-8 -*-
def bubble_sort(alist):
    # 外层循环控制比较几轮
    n = len(alist)
    for j in range(n - 1):#py3 range是做了优化
        # 内存循环控制交换
        # -j是不再换已经排好的
        for i in range(n - 1 - j):
            # 若前一个比后一个大，则换
            if alist[i] > alist[i + 1]:
                alist[i], alist[i + 1] = alist[i + 1], alist[i]

def yanghui():
    l= [1]
    while True:
        yield l
        l= [1]+[l[i]+l[i+1] for i in range(len(l)-1)]+[1]
# range函数不包括后边那个数
def result_yanghui():
	n = 0
	for i in yanghui():
	    print(i)
	    n = n + 1
	    if n > 5:
                break
def fanzhuan(data):
    for index in range(len(data)-1,-1,-1):
        yield data[index]
def lines(file):
    for line in file:yield line
    yield '\n'
      
def blocks(file):
    block=[]
    for line in lines(file):   #你得明白lines返回的是一个生成器对象，line是文件里一行数据（文件结束了时候只有'\n'）
        if line.strip(): # strip是一行数据里去掉两端的空格
            block.append(line) # 去掉两端空格的数据添加进list
        elif block: #当'\n'时最后全部处理成功了，也就是文件里极大可能是没有空行的（否则逻辑可能有点乱）
            yield ''.join(block).strip() #又是yield，最后输出所有行的数据
            block=[]#清缓存
#if __name__ == '__main__':
li = [33, 11, 26, 78, 3, 9, 40]
print(li)
bubble_sort(li)
print(li)
result_yanghui()
print ("".join([ i  for i in fanzhuan("asdfgh") ]))
print ([ i  for i in range(5,-1,-1) ])

aa = (i for i in range(10))#生成器
bb = (i for i in ["aa","bb","cc"])
print(next(aa)) 
