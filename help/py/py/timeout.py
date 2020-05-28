#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-
# coding=utf-8
import signal
import time
 
def set_timeout(num, callback):
    def wrap(func):
        def handle(signum, frame):  # �յ��ź� SIGALRM ��Ļص���������һ���������źŵ����֣��ڶ���������the interrupted stack frame.
            raise RuntimeError
 
        def to_do(*args, **kwargs):
            try:
                signal.signal(signal.SIGALRM, handle)  # �����źźͻص�����
                signal.alarm(num)  # ���� num �������
                print('start alarm signal.')
                r = func(*args, **kwargs)
                print('close alarm signal.')
                signal.alarm(0)  # �ر�����
                return r
            except RuntimeError as e:
                callback()
 
        return to_do
 
    return wrap
 
def after_timeout():  # ��ʱ��Ĵ�����
    print("Time out!")
 
@set_timeout(1, after_timeout)  # ��ʱ 2 �볬ʱ
def connect():  # Ҫִ�еĺ���
    print('Finished without timeout.')
 
if __name__ == '__main__':
    connect()
