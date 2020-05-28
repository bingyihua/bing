# -*- coding: UTF-8 -*-

import multiprocessing as mp
import os, time, random


def long_time_task(name):
    print('进程的名称：{0} ；进程的PID: {1} '.format(name, os.getpid()))
    start = time.time()
    time.sleep(random.random() * 3)
    end = time.time()
    print('进程 {0} 运行了 {1} 秒'.format(name, (end - start)))


if __name__ == '__main__':
    print('主进程的 PID：{0}'.format(os.getpid()))
    p = mp.Pool(processes =5)
    for i in range(6):
        p.apply_async(long_time_task, args=(i,))
    p.close()
    # 等待所有子进程结束后在关闭主进程
    p.join()
    print('【End】')
