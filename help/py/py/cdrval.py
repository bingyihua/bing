#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-
tulp1 = {'test_two': '124', 'test_four': '185','test_one': '196', 'test_three': '26', 'test_five': '489'}
tulp2 = {'test_two': '124', 'test_one': '196', 'test_three': '26'}

for i in tulp2:
    for j in tulp1:
        if i == j:
            if tulp1[i] == tulp2[j]:
                print i, tulp1[i], ":the same"
            else:
                break

for n in tulp1:
    if n not in tulp2:
        print n+"��tulp2������"
for m in tulp2:
    if m not in tulp1:
        print m+"��tulp1������"
#dif = set(tulp1.items())^set(tulp2.items())
            
#print dif



import cx_Oracle
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
#����һ������ʵ��
curs = conn.cursor()
#����һ�������α�
sql ="select T.ERR_CD,T.CALLED_PARTY from  vltdba.err_cdr_vlt_551 t  where t.ERR_CD='F370'"

#ִ��sql���
curs.execute (sql)
dict1=[]
#����һ�������Ų�ѯ������
for inputting in curs:
    #�α��ÿһ�е����ݴ浽inputting�����У�ÿ�е�ÿ���ֶζ���inputting�����Ԫ��    
    #dict1[inputting[0]] = inputting[1]
    #dict1.setdefault("haha",30000)
    #����ֵ䣬�ֵ䲻�����ظ�key������ظ����ͬһ��key��������һ��key��ӵ��ֵ�
    dict1.append(str(inputting[0])+":"+str(inputting[1]))
curs.close()
conn.close()
#�ر��α������
print dict1
