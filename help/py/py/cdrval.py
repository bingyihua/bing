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
        print n+"在tulp2不存在"
for m in tulp2:
    if m not in tulp1:
        print m+"在tulp1不存在"
#dif = set(tulp1.items())^set(tulp2.items())
            
#print dif



import cx_Oracle
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
#创建一个连接实例
curs = conn.cursor()
#创建一个操作游标
sql ="select T.ERR_CD,T.CALLED_PARTY from  vltdba.err_cdr_vlt_551 t  where t.ERR_CD='F370'"

#执行sql语句
curs.execute (sql)
dict1=[]
#创建一个数组存放查询的数据
for inputting in curs:
    #游标把每一行的数据存到inputting数组中，每行的每个字段都是inputting数组的元素    
    #dict1[inputting[0]] = inputting[1]
    #dict1.setdefault("haha",30000)
    #添加字典，字典不能有重复key，如果重复添加同一个key，会把最后一个key添加到字典
    dict1.append(str(inputting[0])+":"+str(inputting[1]))
curs.close()
conn.close()
#关闭游标和连接
print dict1
