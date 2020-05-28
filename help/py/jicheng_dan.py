class grandFather():
  	print('我是爷爷')

class Parent(grandFather):
  	print('我是父类')
  
class SubClass(Parent):
	  print('我是子类')
    
sub = SubClass() 

#结果：我是爷爷
#			我是父类
#			我是子类
#注意：类在定义的时候就执行类体代码，执行顺序是从上到下
