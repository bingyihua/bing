class Student:
    __instance = None

    def __new__(cls, *args, **kwargs):
        if not cls.__instance:
            cls.__instance = object.__new__(cls)
        return cls.__instance

    def sleep(self):
        print('sleeping...')

stu1 = Student()
stu2 = Student()

print(id(stu1), id(stu2))  # 两者输出相同
print(stu1 is stu2)  # True
