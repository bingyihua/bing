class A(object):
    def __init__(self, name):
        self.name=name
        print ("name:", self.name)
    def getName(self):
        return 'A ' + self.nam

#子类不重写__init__，实例化子类时，会自动调用父类定义的__init__
class B(A):
    def getName(self):
        return ('B '+self.name)

#但重写了__init__时，实例化子类，就不会调用父类已经定义的__init__
class C(A):
    def __init__(self, name):
        print ("hi")
        self.name =  name
    def getName(self):
        return 'c '+self.name

#为了能使用或扩展父类的行为，最好显示调用父类的__init__方法
class D(A):
    def __init__(self, name):
        super(D, self).__init__(name)
        print ("hi")
        self.name =  name
    def getName(self):
        return 'D '+self.name
 
if __name__=='__main__':
    b=B('hello')
    print (b.getName())
    c=C('hello')
    print (c.getName())
    d=D('hello')
    print (d.getName())

