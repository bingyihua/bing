#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-

import cx_Oracle
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
#����һ������ʵ��
curs = conn.cursor()
#����һ�������α�
sql ="select count(*) from file_process_transaction  where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat'"
sql1 ="select  PROCESS_RESULT  from file_process_transaction  where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat'"
#global 
count=0;PROCESS_RESULT=0
ok_count=0

for i in range(3):
    print "��"+str(i+1)+"�δ�����"
    while count < 1:
        curs.execute (sql)
        count=int(curs.fetchone()[0])
        pass
    print "���ؿ�ʼ������������"
    while count > 0:
        curs.execute (sql)
        count=int(curs.fetchone()[0])
        curs.execute (sql1)
        PROCESS_RESULT=int(curs.fetchone()[0])
        if PROCESS_RESULT == 2:
            print "��������ɹ�"
            ok_count=1
            break
        elif PROCESS_RESULT > 2:
            print "����ʧ��"
           
            import os
            print "start clear VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat"
            os.system("/opt/mcb/vlt/bin/clr_env_nm_vlt.sh VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat")
            print "start cp  VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat"
            os.system("cp /home/mcbadm/cuiyb/VLTCG01_LNVOLTEAS01_H_110101_20170616114649_10086110.dat /opt/mcb/vlt/data/incoming/571/")
            break
    if PROCESS_RESULT==2:
        print "��������У����򡣡���"

        break
if ok_count<>1:

    print "��������ָ��������û�д���ɹ������˹��Ų�ԭ��"
curs.close()
conn.close()
#�ر��α������
