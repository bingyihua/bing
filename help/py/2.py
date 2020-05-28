a=["flowe","flew","flow","Flight","Fligh"]
max_len=max([len(i) for i in a])
while 1:
    #使用列表解析式的写法更加简短，除此之外，因为是Python内置的用法，底层使用c语言实现，相较于编写Python代码而言，运行速度更快。
    max_len-=1
    b=[i[:max_len] for i in a ]
    max_b=max([b.count(i) for i in b])
    c=set([i for i in b if max_b==b.count(i) and  i.islower()] )
    if c:
        print (c)
        break

