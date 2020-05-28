import os
import paramiko
import collections
import cx_Oracle
import time
a= r"d.bat"
a = os.path.sep.join(a.split(r'/'))
print (a)
os.system(a )



#args="VLTCG01_LNVOLTEAS01_H_110101_20170616114649_88885588.dat"
args="VLTCG01_LNVOLTEAS01_H_110101_20170616114649_88883389.dat"
sdm={
"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250",
"11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771",
"21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991",
"31":"230",
}

prov=sdm[args.split('_' )[3][:2]]
cmd={
"cmd01":"delete from err_cdr_vlt_"+prov+"where ic_file_nm="+args,
"cmd02":"delete from pre_merge_cdr_vlt_hm_"+prov+"where ic_file_nm="+args,
"cmd03":"delete from cdr_dupchk where ic_file_nm="+args,
"cmd04":"delete from pre_merge_file_audit where ic_file_nm="+args,
"cmd05":"delete from FILE_PROCESS_STATE where file_nm="+args,
"cmd06":"delete from FILE_PROCESS_TRANSACTION where file_nm="+args,
"cmd07":"delete from og_file_audit where ic_file_nm="+args,
"cmd08":"delete from ic_file_audit where ic_file_nm="+args,
"cmd09":"delete from pre_merge_cdr_vlt_hm_"+prov+"where ic_file_nm="+args,
}


def clr_env_nm_vlt(args):
	
	conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')   #用自己的实际数据库用户名、密码、主机ip地址 替换即可
	curs=conn.cursor()
	cmd= collections.OrderedDict()

#sql="delete from err_cdr_vlt_571 where ic_file_nm='VLTCG04_VTAS04_H_110104_20161226173300_00315726.dat'" #sql语句不加分号

	for key in cmd:
		rr=curs.execute (cmd[key])	
	conn.commit()	
clr_env_nm_vlt(args)
print('/opt/mcb/vlt/data/incoming/'+prov+'/'+args)
def ftp(args):
	transport = paramiko.Transport(('192.168.117.247', 22))
	transport.connect(username='mcbadm', password='McbUnix_2017')
	sftp = paramiko.SFTPClient.from_transport(transport)#如果连接需要密钥，则要加上一个参数，hostkey="密钥" 
	aa=sftp.put('E:\\soft\\py\\AsnVLT\\dat\\vlt\\'+args, '/opt/mcb/vlt/data/incoming/'+prov+'/'+args)#将本地的Windows.txt文件上传至服务器/root/Windows.txt
	print(aa)

ftp(args)
sql1="select count(*)from file_process_state t where t.file_nm='"+args+"'"
print(sql1)
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
curs=conn.cursor()

age=6
while True:
	time.sleep(3)
	curs.execute (sql1)
	inputting=curs.fetchone()[0]
	print(inputting)
	if inputting >= age:
		break
		cursor.close()
		conn.close()
#time.sleep(5)
conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')
curs=conn.cursor()
curs.execute ("select * from FILE_PROCESS_STATE where file_nm='"+args+"'")
print("-------------------------------------------------------------------------")
for i in  range(inputting): 
	z=curs.fetchone()
	print(z)
curs.close()
conn.close()

print("-------------------------------------------------------------------------")
print("select * from FILE_PROCESS_STATE where file_nm='"+args+"'")
print("select* from err_cdr_vlt_"+prov+" where ic_file_nm='"+args+"'")
print("select* from pre_merge_cdr_vlt_hm_"+prov+" where ic_file_nm='"+args+"'")