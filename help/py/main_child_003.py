import threading
import time


def child_thread1():
    for i in range(10):
        time.sleep(1)
        print('child_thread1_running...')


def child_thread2():
    for i in range(5):
        time.sleep(1)
        print('child_thread2_running...')


def parent_thread():
    print('parent_thread_running...')
    thread1 = threading.Thread(target=child_thread1)
    thread2 = threading.Thread(target=child_thread2)
    thread1.setDaemon(True)
#    thread2.setDaemon(True)
    thread1.start()
    thread2.start()
#   thread2.join()
    #1/0
    thread1.join()
    print('parent_thread_exit...')
#1 python 默认参数创建线程后，不管主线程是否执行完毕，都会等待子线程执行完毕才一起退出，有无join结果一样

#2 如果创建线程，并且设置了daemon为true，即thread.setDaemon(True), 则主线程执行完毕后自动退出，不会等待子线程的执行结果。而且随着主线程退出，子线程也消亡。

#3 join方法的作用是阻塞，等待子线程结束，join方法有一个参数是timeout，即如果主线程等待timeout，子线程还没有结束，则主线程强制结束子线程。

#4 如果线程daemon属性为False， 则join里的timeout参数无效。主线程会一直等待子线程结束。

#5 如果线程daemon属性为True， 则join里的timeout参数是有效的， 主线程会等待timeout时间后，结束子线程。此处有一个坑，即如果同时有N个子线程join(timeout），那么实际上主线程会等待的超时时间最长为 N ＊ timeout， 因为每个子线程的超时开始时刻是上一个子线程超时结束的时刻。
#主线程在执行到thread2.join()时被阻塞，等待thread2结束后才会执行下一句
if __name__ == "__main__":
    parent_thread()

