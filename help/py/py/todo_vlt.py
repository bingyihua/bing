#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-

import cx_Oracle
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
#创建一个连接实例
curs = conn.cursor()
#创建一个操作游标
sql ="select count(*) from file_process_transaction  where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat'"
sql1 ="select  PROCESS_RESULT  from file_process_transaction  where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat'"
#global 
count=0;PROCESS_RESULT=0
ok_count=0

for i in range(3):
    print "第"+str(i+1)+"次处理话单"
    while count < 1:
        curs.execute (sql)
        count=int(curs.fetchone()[0])
        pass
    print "主控开始处理话单。。。"
    while count > 0:
        curs.execute (sql)
        count=int(curs.fetchone()[0])
        curs.execute (sql1)
        PROCESS_RESULT=int(curs.fetchone()[0])
        if PROCESS_RESULT == 2:
            print "话单处理成功"
            ok_count=1
            break
        elif PROCESS_RESULT > 2:
            print "处理失败"
           
            import os
            print "start clear VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat"
            os.system("/opt/mcb/vlt/bin/clr_env_nm_vlt.sh VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat")
            print "start cp  VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat"
            os.system("cp /home/mcbadm/cuiyb/VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat /opt/mcb/vlt/data/incoming/571/")
            break
    if PROCESS_RESULT==2:
        print "开启调用校验程序。。。"

        break
if ok_count<>1:

    print "话单处理指定次数仍没有处理成功，请人工排查原因"
curs.close()
conn.close()
#关闭游标和连接
