#getattr
class Person(object):
    def __init__(self,name):
        self.name = name
    def talk(self):
        print("%s正在交谈"%self.name)
p = Person("laowang")

n = getattr(p,"name")   # 获取name变量的内存地址
print(n)                # 此时打印的是:laowang

f = getattr(p,"talk")   # 获取talk方法的内存地址
f()                     # 调用talk方法

#我们发现getattr有三个参数，那么第三个参数是做什么用的呢?
s = getattr(p,"abc","not find")
print(s)                # 打印结果：not find。因为abc在对象p中找不到，本应该报错，属性找不到，但因为修改了找不到就输出not find

#hasattr
class Person(object):
    def __init__(self,name):
        self.name = name
    def talk(self):
        print("%s正在交谈"%self.name)

p = Person("laowang")        
print(hasattr(p,"talk"))    # True。因为存在talk方法
print(hasattr(p,"name"))    # True。因为存在name变量
print(hasattr(p,"abc"))     # False。因为不存在abc方法或变量

#setattr
def abc(self):
    print("%s正在交谈"%self.name)

class Person(object):
    def __init__(self,name):
        self.name = name

p = Person("laowang")
setattr(p,"talk",abc)   # 将abc函数添加到对象中p中，并命名为talk
p.talk(p)               # 调用talk方法，因为这是额外添加的方法，需手动传入对象
setattr(p,"age",30)     # 添加一个变量age,复制为30
print(p.age)            # 打印结果:30

#delattr
class Person(object):
    def __init__(self,name):
        self.name = name
    def talk(self):
        print("%s正在交谈"%self.name)

p = Person("laowang")
delattr(p,"name")       # 删除name变量
#print(p.name)           # 此时将报错
