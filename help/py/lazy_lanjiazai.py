class lazy(object): 
  def __init__(self, func): 
    self.func = func   #lazy的实例属性func等于area方法对象
  
  def __get__(self, instance, cls): 
    val = self.func(instance) #调用area方法计算出结果
    setattr(instance, self.func.__name__, val) #将结果设置给c的area属性
    return val 
  
class Circle(object): 
  def __init__(self, radius): 
    self.radius = radius 
  
  @lazy  #area = lazy(area) lazy描述符
  def area(self): 
    print ('evalute')
    return 3.14 * self.radius ** 2
  
c = Circle(4) 
print (c.radius)
print (c.area) 
print (c.area) 
print (c.area)
