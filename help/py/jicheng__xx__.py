class MySQL:
    def connect(self):
        print('启动数据库连接，申请系统资源')

    def execute(self):
        print('执行sql命令，操作数据')

    def finish(self):
        print('数据库连接关闭，清理系统资源')

    def __enter__(self):  # with的时候触发，并赋给as变量
        self.connect()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):  # 离开with语句块时触发
        self.finish()

with MySQL() as mysql:
    mysql.execute()
    
# 结果:
# 启动数据库连接，申请系统资源
# 执行sql命令，操作数据
# 数据库连接关闭，清理系统资源
