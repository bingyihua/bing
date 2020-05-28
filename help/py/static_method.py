class A(object):
    a = 'a'
    @staticmethod
    def foo1(name):
        print ('hello', name)
    def foo2(self, name):
        print ('hello', name)
    @classmethod
    def foo3(cls, name):
        print ('hello', name)

a = A()
a.foo1('mamq') # 输出: hello mamq
A.foo1('mamq')# 输出: hello mamq
a.foo2('mamq') # 输出: hello mamq
#A.foo2(i'mamq') # 报错: unbound method foo2() must be called with A instance as first argument (got str instance instead)
#一般来说，要使用某个类的方法，需要先实例化一个对象再调用方法。
#@staticmethod或@classmethod，就可以不需要实例化，直接类名.方法名()来调用。
# @staticmethod不需要表示自身对象的self和自身类的cls参数，就跟使用函数一样。
# @classmethod也不需要self参数，但第一个参数需要是表示自身类的cls参数。
#https://blog.csdn.net/handsomekang/article/details/9615239
