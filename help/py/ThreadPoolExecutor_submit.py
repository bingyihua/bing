# -*- coding: utf-8 -*-
# (C) Guangcai Ren <renguangcai@jiaaocap.com>
# All rights reserved
# create time '2019/6/26 14:41'
import math
import random
import time
from concurrent.futures import ThreadPoolExecutor

# 线程池list
pool_list = []


def split_df(pool):
    # 需要处理的数据
    _l = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    # 每个线程处理的数据大小
    split_count = 2
    # 需要的线程个数
    times = math.ceil(len(_l) / split_count)
    count = 0
    for item in range(times):
        _list = _l[count: count + split_count]
        # 线程相关处理
        # submit方法提交可回调的函数，并返回一个future实例；future对象包含相关属性
        # 如: done(函数是否执行完成),result(函数执行结果),running(函数是否正在运行)
        # 从而 可以在submit 后的代码中 查看 相关任务运行情况
        # 此方法 执行数据的结果是无序的，如果需要得到有序的结果，需要 for循环 每个future实例(线程池)，如 此脚本代码
        f = pool.submit(work, item, _list)
        pool_list.append(f)
        count += split_count


def work(df, _list):
    """ 线程执行的任务，让程序随机sleep几秒

    :param df:
    :param _list:
    :return:
    """
    sleep_time = random.randint(1, 5)
    print(f'count is {df},sleep {sleep_time},list is {_list}')
    time.sleep(sleep_time)
    return sleep_time, df, _list


def use():
    #max_workers参数来设置线程池中最多能同时运行的线程数目
    pool = ThreadPoolExecutor(max_workers=5)
    split_df(pool)
    _result_list = []
    for item in pool_list:
        #线程组会放回一个元组
        result_tuple = item.result()
        _result_list.append(result_tuple[1])
    return _result_list


if __name__ == '__main__':
    _result_list = use()
    print(len(_result_list), _result_list)
