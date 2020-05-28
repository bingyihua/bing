#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
#关于“互斥”和“同步”的概念
#答案很清楚了，互斥就是线程A访问了一组数据，线程BCD就不能同时访问这些数据，直到A停止访问了
#同步就是ABCD这些线程要约定一个执行的协调顺序，比如D要执行，B和C必须都得做完
import threading, time
#实用锁可以达到线程同步，但是在更复杂的环境，需要针对锁进行一些条件判断。Python 提供了 Condition 对象。
class Consumer(threading.Thread):
    #消费者
    def __init__(self, cond, name):
        # 初始化
        #这是对继承自父类的属性进行初始化。而且是用父类的初始化方法来初始化继承的属性。
        #也就是说，子类继承了父类的所有属性和方法，父类属性自然会用父类方法来进行初始化。
        #当然，如果初始化的逻辑与父类的不同，不使用父类的方法，自己重新初始化也是可以的
        super(Consumer, self).__init__()
        self.cond = cond
        self.name = name

    def run(self):
        # 确保先运行Seeker中的方法
        time.sleep(1)
        #请求对 Lock 或 RLock 加锁
        self.cond.acquire()
        print(self.name + '1: 我这两件商品一起买，可以便宜点吗')
        
        self.cond.notify()
        #消费的notify() 会激活其他线程(生产者)的wait
        self.cond.wait()
        #消费者的wait等待生产者的notify()来激活，消费者的notify()不能激活消费者的wait
        print(self.name + ': 我已经提交订单了，你修改下价格')
        self.cond.notify()
        self.cond.wait()
        print(self.name + ': 收到，我支付成功了')
        self.cond.notify()
        self.cond.release()
        #release()释放锁
        print(self.name + ': 等待收货')


class Producer(threading.Thread):
    #生产者
    def __init__(self, cond, name):
        super(Producer, self).__init__()
        self.cond = cond
        self.name = name

    def run(self):
        self.cond.acquire()
        # 释放对琐的占用，同时线程挂起在这里，直到被 notify 并重新占有琐。
        #wait和notify这两个方法，这两个方法属于threading的Condition
        self.cond.wait()
        print(self.name + ': 可以的，你提交订单吧')
        self.cond.notify()
        self.cond.wait()
        print(self.name + ': 好了，已经修改了')
        self.cond.notify()
        self.cond.wait()
        print(self.name + ': 嗯，收款成功，马上给你发货')
        self.cond.release()
        print(self.name + ': 发货商品')


cond = threading.Condition()
consumer = Consumer(cond, '买家（两点水）')
producer = Producer(cond, '卖家（三点水）')
consumer.start()
producer.start()
