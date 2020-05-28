# -*- coding: UTF-8 -*-
from queue import Queue
from threading import Thread
isRead = True
#https://segmentfault.com/q/1010000012483275/a-1020000012487229
#queue是线程安全的          
def write(q):
    # 写数据进程
    for value in ['两点水', '三点水', '四点水']:
        print('写进 Queue 的值为：{0}'.format(value))
        q.put(value)
        if q.empty() == True:
            break
def read(q):
    # 读取数据进程
    while isRead:
        value = q.get(True)
        print('从 Queue 读取的值为：{0}'.format(value))
        if q.empty() == True:
            break
def read_write(q):
    t1 = Thread(target=write, args=(q,))
    t2 = Thread(target=read, args=(q,))
    t1.start()
    t2.start()
if __name__ == '__main__':
    q = Queue()
    read_write(q) 
