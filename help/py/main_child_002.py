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
    thread1.start()
    thread2.start()
    print('parent_thread_exit...')

#主线程结束后进程不等待守护线程完成，立即结束
#setDaemon(True)为守候进程
if __name__ == "__main__":
    parent_thread()
