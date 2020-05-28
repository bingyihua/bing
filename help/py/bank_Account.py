import threading
import Account1 as Account
#导入py文件，当前目录 Account1.py 的class必须是Account
# 定义一个函数来模拟取钱操作
def draw(account, draw_amount):
# 直接调用account对象的draw()方法来执行取钱操作
    account.draw(draw_amount)
    # 创建一个账户
acct = Account.Account("1234567" , 1000)
    # 模拟两个线程对同一个账户取钱
threading.Thread(name='甲', target=draw , args=(acct , 800)).start()
threading.Thread(name='乙', target=draw , args=(acct , 800)).start()
