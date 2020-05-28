#io密集型：多线程效率高
from multiprocessing import Process
from threading import Thread
import threading
import os,time
def work():
        time.sleep(2)
        print('===>')
l=[]
print(os.cpu_count()) #本机为4核
start=time.time()
for i in range(400):
        p=Process(target=work) #耗时4s多,大部分时间耗费在创建进程上
        # p=Thread(target=work) #耗时2s多
        l.append(p)
        p.start()
for p in l:
        p.join()
stop=time.time()
print('run time is %s' %(stop-start))
