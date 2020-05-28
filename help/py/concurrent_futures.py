import time
from concurrent import futures
from concurrent.futures import ThreadPoolExecutor
def display(args):
    print(time.strftime('[%H:%M:%S]', time.localtime()), end=' ')
    print(args)
def task(n):
    """只是休眠"""
    display('begin sleep {}s.'.format(n))
    time.sleep(n)
    display('ended sleep {}s.'.format(n))
def do_many_task_inorder():
    """多线程
    按任务发布顺序依次等待完成
    """
    tasks = [5, 4, 3, 2, 1]
    with ThreadPoolExecutor(max_workers=3) as executor:
        future_list = [executor.submit(task, arg) for arg in tasks]
        display('非阻塞运行')
        for future in future_list:
            display(future)
        display('统一结束(有序)')
        for future in future_list:
            display(future.result())
def do_many_task_disorder():
    """多线程执行
    先完成先显示
    """
    tasks = [5, 4, 3, 2, 1]
    with ThreadPoolExecutor(max_workers=3) as executor:
        future_list = [executor.submit(task, arg) for arg in tasks]
        display('非阻塞运行')
        for future in future_list:
            display(future)
        display('统一结束(无序)')
        done_iter = futures.as_completed(future_list)  # generator
        for done in done_iter:
            display(done)
if __name__ == '__main__':
    do_many_task_inorder()
    do_many_task_disorder()
