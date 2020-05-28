#一切皆文件
import abc #利用abc模块实现抽象类
class All_file(metaclass=abc.ABCMeta):
    all_type='file'
    @abc.abstractmethod #定义抽象方法，无需实现功能
    def read(self):
        '子类必须定义读功能'
        pass
    @abc.abstractmethod #定义抽象方法，无需实现功能
    def write(self):
        '子类必须定义写功能'
        pass
# class Txt(All_file):
#     pass
#
# t1=Txt() #报错,子类没有定义抽象方法
class Txt(All_file): #子类继承抽象类，但是必须定义read和write方法
    def read(self):
        print('文本数据的读取方法')
    def write(self):
        print('文本数据的读取方法')
class Sata(All_file): #子类继承抽象类，但是必须定义read和write方法
    def read(self):
        print('硬盘数据的读取方法')
    def write(self):
        print('硬盘数据的读取方法')
class Process(All_file): #子类继承抽象类，但是必须定义read和write方法
    def read(self):
        print('进程数据的读取方法')
    def write(self):
        print('进程数据的读取方法')

wenbenwenjian=Txt()
yingpanwenjian=Sata()
jinchengwenjian=Process()
#这样大家都是被归一化了,也就是一切皆文件的思想
wenbenwenjian.read()
yingpanwenjian.write()
jinchengwenjian.read()
print(wenbenwenjian.all_type)
print(yingpanwenjian.all_type)
print(jinchengwenjian.all_type)

#抽象类的本质还是类，指的是一组类的相似性，包括数据属性（如all_type）和函数属性（如read、write），而接口只强调函数属性的相似性。
#抽象类是一个介于类和接口直接的一个概念，同时具备类和接口的部分特性，可以用来实现归一化设计 
#在python中，并没有接口类这种东西，即便不通过专门的模块定义接口，我们也应该有一些基本的概念。
"""1.多继承问题
在继承抽象类的过程中，我们应该尽量避免多继承；
而在继承接口的时候，我们反而鼓励你来多继承接口
2.方法的实现
在抽象类中，我们可以对一些抽象方法做出基础实现；
而在接口类中，任何方法都只是一种规范，具体的功能需要子类实现"""
