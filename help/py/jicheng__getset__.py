class StudentManager:
    li = []
    dic = {}

    def add(self, obj):
        self.li.append(obj)
        self.dic[obj.name] = obj

    def __getitem__(self, item):
        if isinstance(item, int):
            # 通过下标得到对象
            return self.li[item]
        elif isinstance(item, slice):
            # 通过切片得到一串对象
            start = item.start
            stop = item.stop
            return [student for student in self.li[start:stop]]
        elif isinstance(item, str):
            # 通过名字得到对象
            return self.dic.get(item, None)
        else:
            # 给定的key类型错误
            raise TypeError('你输入的key类型错误!')

class Student:
    manager = StudentManager()

    def __init__(self, name):
        self.name = name

        self.manager.add(self)

    def __str__(self):
        return f'学生: {self.name}'

    __repr__ = __str__


stu1 = Student('小明')
stu2 = Student('大白')
stu3 = Student('小红')
stu4 = Student('胖虎')

# 当做列表使用
print(Student.manager[0])  # 学生: 小明
print(Student.manager[-1])  # 学生: 胖虎
print(Student.manager[1:3])  # [学生: 大白, 学生: 小红]

# 当做字典使用
print(Student.manager['胖虎'])  # 学生: 胖虎
