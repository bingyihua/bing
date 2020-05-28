class Parent2():
    print('我是第二个爹')

class Parent():
    print('我是第一个爹')
    
class SubClass(Parent, Parent2):
    print('我是子类')
    
#	
# 结果：我是第二个爹
#			 我是第一个爹
# 		 我是子类
#注意：类在定义的时候就执行类体代码，执行顺序是从上到下
