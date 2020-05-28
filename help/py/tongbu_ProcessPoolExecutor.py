from concurrent.futures import ProcessPoolExecutor
# 进程池模块
import os, time, random


# 1、同步调用： 提交完任务后、就原地等待任务执行完毕，拿到结果，再执行下一行代码（导致程序串行执行）
def talk(name):
    print('name: %s  pis%s  run' % (name,os.getpid()))  
    time.sleep(random.randint(1, 3))

if __name__ == '__main__':
    pool = ProcessPoolExecutor(4)
    for i in range(10):
        pool.submit(talk, '进程%s' % i).result()  # 同步调用，result()，相当于join 串行

    pool.shutdown(wait=True)
    print('主进程')
