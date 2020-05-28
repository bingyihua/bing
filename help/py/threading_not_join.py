#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
#Python 提供两个模块进行多线程的操作，分别是 thread 和 threading
#前者是比较低级的模块，用于更底层的操作，一般应用级别的开发不常用。
#因此，我们使用 threading 来举个例子：
import time
import threading

class MyThread(threading.Thread):
    def run(self):
        for i in range(5):
            print('thread {}, @number: {}'.format(self.name, i))
            time.sleep(1)

def main():
    print("Start main threading")

    # 创建三个线程
    threads = [MyThread() for i in range(3)]
    # 启动三个线程
    for t in threads:
        t.start()

    print("End Main threading")

if __name__ == '__main__':
    main()
