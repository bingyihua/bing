from threading import Thread
from threading import Thread, Lock, enumerate 
 
list_a = [1, 2, 3]
mutex = Lock()
 
def add_list():
    global list_a
    mutex.acquire()
    list_a.append(100)
    print(list_a)
    mutex.release() 
 
if __name__ == '__main__':
    t1 = Thread(target=add_list)
    t2 = Thread(target=add_list)
    print(t1.name)
    t1.start()
    print(t2.name)
    t2.start()
