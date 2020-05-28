from multiprocessing import Process, Queue

def producer(q):  # 生产
    for i in range(1, 6):
        q.put(i)  # 添加一个任务
        print("生产%s馒头" % i)

def consumer(q):  # 消费
    while 1:
        sth = q.get()
        print("消费%s馒头" % sth)

if __name__ == '__main__':
    q = Queue(4)
    p1 = Process(target=producer, args=(q, ))
    p2 = Process(target=producer, args=(q, ))
    p3 = Process(target=producer, args=(q, ))
    c1 = Process(target=consumer, args=(q, ))
    c2 = Process(target=consumer, args=(q, ))

    # 将消费者设置为守护进程，因为消费者里面是死循环
    c1.daemon = True
    c2.daemon = True

    p1.start()
    p2.start()
    p3.start()
    c1.start()
    c2.start()

    p1.join()
    p2.join()
    p3.join()
    print("stop")
