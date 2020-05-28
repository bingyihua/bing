import threading
import time


def child_thread1():
    for i in range(10):
        time.sleep(1)
        print('child_thread1_running...')


def parent_thread():
    print('parent_thread_running...')
    thread1 = threading.Thread(target=child_thread1)
    thread1.start()
    print('parent_thread_exit...')
#对于程序来说，如果主进程在子进程还未结束时就已经退出，那么Linux内核会将子进程的父进程ID改为1（也就是init进程），当子进程结束后会由init进程来回收该子进程。

if __name__ == "__main__":
    parent_thread()
