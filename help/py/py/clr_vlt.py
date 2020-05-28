import cx_Oracle

args="VLTCG01_LNVOLTEAS01_H_110101_20170616114649_88885588.dat"
#args="VLTCG01_LNVOLTEAS01_H_110101_20170616114649_88883389.dat"
sdm={
"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250",
"11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771",
"21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991",
"31":"230",
}
prov=sdm[args.split('_' )[3][:2]]
cmd={
"cmd01":"delete from err_cdr_vlt_"+prov+" where ic_file_nm='"+args+"'",
"cmd02":"delete from pre_merge_cdr_vlt_hm_"+prov+" where ic_file_nm='"+args+"'",
"cmd03":"delete from cdr_dupchk where ic_file_nm='"+args+"'",
"cmd04":"delete from pre_merge_file_audit where ic_file_nm='"+args+"'",
"cmd05":"delete from FILE_PROCESS_STATE where file_nm='"+args+"'",
"cmd06":"delete from FILE_PROCESS_TRANSACTION where file_nm='"+args+"'",

"cmd08":"delete from ic_file_audit where ic_file_nm='"+args+"'",
"cmd09":"delete from pre_merge_cdr_vlt_hm_"+prov+" where ic_file_nm='"+args+"'",
}
def clr_env_nm_vlt(args):
    
    conn = cx_Oracle.connect('vltdba/HyxtTest_9@192.168.117.223/vlt')   #用自己的实际数据库用户名、密码、主机ip地址 替换即可
    curs=conn.cursor()
    #cmd= collections.OrderedDict()

#sql="delete from err_cdr_vlt_571 where ic_file_nm='VLTCG04_VTAS04_H_110104_20161226173300_00315726.dat'" #sql语句不加分号

    for key in cmd:
        rr=curs.execute (cmd[key])  
    conn.commit()
    curs.close()                                                 #关闭cursor
    conn.close()    
#clr_env_nm_vlt("'"+args+"'")
clr_env_nm_vlt(args)