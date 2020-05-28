#!/usr/bin/env python
# -*- coding:utf-8 -*-
# 进行线程之间的通信的原理：一个进程内的多个线程，使用的是同一个虚拟地址空间
from threading import Thread
# 创建一个队列来实现线程之间的通信，但是这是线程不安全的，调用的时候需要使用lock
# 而Queue是线程安全的队列，调用时不用处理
from queue import Queue


# io线程
class ioThread(Thread):
    def __init__(self, queue):
        # 要调用分类的构造器
        Thread.__init__(self)
        self.queue = queue

    def run(self):
        # io线程创建数据
        self.queue.put((1, 2))
        print ("执行了io操作")


# cpu线程
class cpuThread(Thread):
    def __init__(self, queue):
        # 要调用分类的构造器
        Thread.__init__(self)
        self.queue = queue

    def run(self):
        while True:
            # 从队列中取数据
            print ("========")
            first, second = self.queue.get()
            print (first, second)
            print ("执行了cpu密集型操作")


# ===========类似生产者和消费者模式==============
q = Queue()
ios = [ioThread(q) for i in range(1, 11)]
for io in ios:
    io.start()
cpu = cpuThread(q)
cpu.start()

