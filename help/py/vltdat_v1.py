# -*- coding: utf-8 -*-
import os
import sys
import random
from lxml import etree
import re
import cx_Oracle
import paramiko
# reload(sys)
# sys.setdefaultencoding( "utf-8" )
# if os.path.exists(my_file):
#     os.remove(my_file)
mobile ="""iFileLength#6541
iHeaderLength#50
iHighReleaseIdentifier#5
iHighVersionIdentifier#2
iLowReleaseIdentifier#5
iLowVersionIdentifier#2
FileOpeningTime#
LastTime#
iCDRCount#1
iSequenceNumber#38127
iClosureTrigger#2
sIPAddress#
iLostCDR#0
iRouteingLength#0"""
body="""<IMSRecord>
    <aSRecord>
        <record-Type>69</record-Type>
        <sIP-Method>BYE</sIP-Method>
        <role-of-Node>0</role-of-Node>
        <node-Address>
            <domainName>syvoltetas1bhw.voltetas.ln.chinamobile.com</domainName>
        </node-Address>
        <session-ID>asbc2380788698_175785720@2409:8803:e00:1bc:1d8b:de04:4fbe:786d</session-ID>
        <list-Of-Calling-Party-Address>
                <tEL-URI>tel:+8615804164154</tEL-URI>
        </list-Of-Calling-Party-Address>
        <called-Party-Address>
            <tEL-URI>tel:10086</tEL-URI>
        </called-Party-Address>
        <service-Request-Time-Stamp>160416114130+0800</service-Request-Time-Stamp>
        <service-Delivery-Start-Time-Stamp>160416114133+0800</service-Delivery-Start-Time-Stamp>
        <service-Delivery-End-Time-Stamp>160416114149+0800</service-Delivery-End-Time-Stamp>
        <record-Opening-Time>160416114133+0800</record-Opening-Time>
        <record-Closure-Time>160416114149+0800</record-Closure-Time>
        <inter-Operator-Identifiers>
            <originating-IOI>ln.chinamobile.com</originating-IOI>
            <terminating-IOI>10.184.149.28</terminating-IOI>
        </inter-Operator-Identifiers>
        <local-Record-Sequence-Number>49269488</local-Record-Sequence-Number>
        <cause-For-Record-Closing><service-Delivery-End-Successfully/></cause-For-Record-Closing>
        <iMS-Charging-Identifier>sypsbc2bhw.194.a6c4.20160416034130</iMS-Charging-Identifier>
        <service-Reason-Return-Code>0</service-Reason-Return-Code>
        <access-Network-Information>3GPP-E-UTRAN;utran-cell-id-3gpp=460001213F100082;sbc-domain=sbc2.013.ln.chinamobile.com;ue-ip=[2409:8803:E00:1BC:1D8B:DE04:4FBE:786D];ue-port=8003;network-provided</access-Network-Information>
        <ims-Visited-Network-Identifier>"sypsbc2bhw.ln.ims.mnc000.mcc460.3gppnetwork.org"</ims-Visited-Network-Identifier>
        <requested-Party-Address>
            <tEL-URI>tel:10086</tEL-URI>
        </requested-Party-Address>
        <online-Charging-Flag><offline-Charging/></online-Charging-Flag>
        <charged-Party>
            <tEL-URI>tel:+8615804164154</tEL-URI>
        </charged-Party>
        <duration>16</duration>
        <sDP-Media-Identifier><voiceCall/></sDP-Media-Identifier>
        <calling-Party>
            <tEL-URI>tel:+8615804164154</tEL-URI>
        </calling-Party>
        <cS-Location-Information>
        </cS-Location-Information>
    </aSRecord>
</IMSRecord>"""
#called=[13233,12233,111113]
#calling=[1222233]
typecall=1 # 0是主叫，1是被叫

br_switch=1 # 1为边漫游话单，2是本地，3是漫游
auto=1   #  1用函数生成主被叫号码，0是用给定数组生成话单
#yystype  , 1为移动，2是联通，3是电信
global calling_prov
#######################################################################################################
def make_nuber(yystype,prov1,count):


    conn = cx_Oracle.connect('mcbdba/HyxtTest_9@192.168.117.223/vlt')
    curs=conn.cursor()
    if yystype==1 :
        sql01="select t.imsi_area_id,t.msisdn_area_id,t.ld_area_cd,t.imsi_type ,rownum  from mcbdba.IMSI_LD_CD t where t.LD_AREA_CD in \
       (select ld_area_cd from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD=571 )\
        and t.effc_tm<sysdate and  t.imsi_type=1 and t.expired_tm>sysdate and rownum<=6 "
        sql1=sql01.replace("rownum<=6","rownum<="+str(count)).replace("PROV_CD=571","PROV_CD="+str(prov1))
        # print sql1,prov1
        curs.execute (sql1)
        call=[]
        diqu=[]
        for i in range(count):
            inputting=curs.fetchone()
            call.append(inputting[1]+"1111")
            diqu.append(inputting[2])

        print ("号码为移动号码，省代码:" +str(prov1)+"号码："+str(call))
    if yystype==2 :
        sql02=" select t.ld_area_cd,t.msisdn_area_id,t.carrier_type ,rownum  from mcbdba.UNICOM_MSISDN_LD_CD t where t.LD_AREA_CD in \
        (select ld_area_cd from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD='571' )\
        and t.effc_tm<sysdate and t.expired_tm>sysdate and t.carrier_type=01 and rownum<=6 "
        sql2=sql02.replace("rownum<=6","rownum<="+str(count)).replace("PROV_CD='571'","PROV_CD="+"'"+str(prov1)+"'")
        # print sql2,
        curs.execute (sql2)
        call=[]
        diqu=[]
        for i in range(count):
            inputting=curs.fetchone()
            call.append(inputting[1]+"1111")
            diqu.append(inputting[0])
        print ("号码为联通号码，省代码:" +str(prov1)+"号码："+str(call))
    if yystype==3 :
        sql03=" select t.ld_area_cd,t.msisdn_area_id,t.carrier_type ,rownum  from mcbdba.UNICOM_MSISDN_LD_CD t where t.LD_AREA_CD in \
        (select ld_area_cd from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD='571' )\
        and t.effc_tm<sysdate and t.expired_tm>sysdate and t.carrier_type=02 and rownum<=6 "
        sql3=sql03.replace("rownum<=6","rownum<="+str(count)).replace("PROV_CD=571","PROV_CD="+str(prov1))
        #print sql1
        curs.execute (sql3)
        call=[]
        diqu=[]

        for i in range(count):
            inputting=curs.fetchone()
            call.append(inputting[1]+"1111")
            diqu.append(inputting[0])
            print (diqu)
        #print call
        curs.close()
        conn.close()
        print ("号码为电信号码，省代码:" +str(prov1)+"号码："+str(call)+str(diqu))
    return diqu,call,prov1
#######################################################################################################

if auto==1:

    abc=make_nuber(1,571,1)

    calling=abc[1]
    print ("归属地区长途区号代码"+str(abc[0]))
    global gsctqh, myctqh
    gsctqh =str(abc[0][0])
    #print abc[0][0]
    calling_prov=str(abc[2])
    print ("上发省代码为："+str(calling_prov))
    cba=make_nuber(2,451,3)
    called=cba[1]
    myctqh=str(cba[0][0])
    print ("拜访省长途区号"+str(cba[0][0]))
    #print diqu
else:
    print ("使用数组生成主被叫号码")
calling_num=len(calling)
called_num=len(called)
i=0
for i in range(calling_num*called_num):
    a="iCDRCount#"+str(i+1)
    mm=mobile.replace("iCDRCount#1",a)
#print (m)
file = r'tt.xml'
with open(file, 'w') as f:
    f.write(mm+'\n')
temp = body
if  br_switch==1:


    word = re.compile(r'46000(.{11})')
    wordreglist = re.findall(word,temp)
    #print wordreglist[0]
    temp=body.replace( str(wordreglist[0]),str(gsctqh)+"F100082")
    conn = cx_Oracle.connect('mcbdba/HyxtTest_9@192.168.117.223/vlt')
    curs=conn.cursor()
    sql="select t.ld_area_cd ,rownum from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD <>571 and rownum=1"
    sql1=sql.replace("PROV_CD <>571","PROV_CD <>"+str(abc[2]))
    #print sql1
    curs.execute (sql1)

    inputting=curs.fetchone()
    #print inputting[0]
    temp_body=temp.replace("sbc2.013","sbc2."+inputting[0])
    # print wordreglist[0]
    sql= "select  count(*) from BR_MSC_COVER_AREA_CD where LAC_ID||CELL_ID="+"'"+str(myctqh)+"F100082"+"'"+" and COVER_AREA_CD=0591 and   expired_tm>sysdate and EFFC_TM<sysdate "
    sql2=sql.replace("COVER_AREA_CD=0591","COVER_AREA_CD="+gsctqh)
    print (sql2)
    curs.execute (sql2)
    jg=curs.fetchone()[0]

    if typecall==0:
        print ("生成边境主叫漫游话单文件")
        if jg > 0:

            print (jg)
            print ("已存在边漫游公参，不需要重启校验程序，如果之前有插入公参仍需重启校验程序")
        elif jg==0:
            print ("插入边漫游公参,需要重启校验程序，再放话单")
            sql2="insert into MCBDBA.BR_MSC_COVER_AREA_CD (PROV_CD, LAC_ID, CELL_ID, COVER_PROV_CD, COVER_AREA_CD, EFFC_TM, EXPIRED_TM, OPT_TM, TIME_STAMP, OPT_TYPE)\
             values (571, "+myctqh+", 'F100082',591,'0570' ,to_date('23-03-2007', 'dd-mm-yyyy'), to_date('31-12-2099', 'dd-mm-yyyy'), to_date('18-10-2017 16:40:07', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-04-2018 08:58:18', 'dd-mm-yyyy hh24:mi:ss'), 'I')"
            curs.execute (sql2.replace("'0570'","'"+myctqh+"'"))
            conn.commit()
    else :
        print ("生成边境被叫漫游话单文件")
        temp_body=temp.replace("sbc2.013","sbc2."+"010")
        sql= "select  count(*) from BR_MSC_COVER_AREA_CD where LAC_ID||CELL_ID="+"'"+str(myctqh)+"F100082"+"'"+" and COVER_AREA_CD=0591 and   expired_tm>sysdate and EFFC_TM<sysdate "
        sql2=sql.replace("COVER_AREA_CD=0591","COVER_AREA_CD="+myctqh)
        curs.execute (sql2)
        jg1=curs.fetchone()[0]
        print (jg1)
        if jg1 > 0:
            print ("已存在边漫游公参，不需要重启校验程序，如果之前有插入公参仍需重启校验程序")
        else:
            print ("插入边漫游公参,需要重启校验程序，再放话单")
            sql2="insert into MCBDBA.BR_MSC_COVER_AREA_CD (PROV_CD, LAC_ID, CELL_ID, COVER_PROV_CD, COVER_AREA_CD, EFFC_TM, EXPIRED_TM, OPT_TM, TIME_STAMP, OPT_TYPE)\
             values (571, "+"'"+myctqh.zfill(4)+"'"+", 'F100082',591,"+"'"+myctqh+"'"+" ,to_date('23-03-2007', 'dd-mm-yyyy'), to_date('31-12-2099', 'dd-mm-yyyy'), to_date('18-10-2017 16:40:07', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-04-2018 08:58:18', 'dd-mm-yyyy hh24:mi:ss'), 'I')"
            curs.execute (sql2)
            conn.commit()
            print (sql2)


    curs.close()
    conn.close()


if  br_switch==2:
    conn = cx_Oracle.connect('mcbdba/HyxtTest_9@192.168.117.223/vlt')
    curs=conn.cursor()
    sql="select t.ld_area_cd ,rownum from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD =571 and rownum=1"
    sql1=sql.replace("PROV_CD =571","PROV_CD ="+str(abc[2]))
    #print sql1
    curs.execute (sql1)
    inputting=curs.fetchone()
    #print inputting[0]

    temp_body=temp.replace("sbc2.013","sbc2."+inputting[0])
    if typecall==0:
        print ("生成主叫本地话单文件")
    else :
        print ("生成被叫本地话单文件")
        temp_body=temp.replace("sbc2.013","sbc2."+gsctqh)
if  br_switch==3:
    temp = body
    word = re.compile(r'46000(.{9})')
    wordreglist = re.findall(word,temp)
    sss=wordreglist[0]+str(random.randint(10, 59))

    conn = cx_Oracle.connect('mcbdba/HyxtTest_9@192.168.117.223/vlt')
    curs=conn.cursor()
    sql="select t.ld_area_cd ,rownum from mcbdba.dom_ld_area_cd_prov_ext t where t.PROV_CD <>571 and rownum=1"
    sql1=sql.replace("PROV_CD <>571","PROV_CD <>"+str(abc[2]))
    #print sql1
    curs.execute (sql1)
    inputting=curs.fetchone()
    #print inputting[0]
    temp_body=temp.replace("sbc2.013","sbc2."+inputting[0]).replace("1213F100082",sss)
    if typecall==0:
        print ("生成主叫漫游话单文件")
    else :
        print ("生成被叫漫游话单文件")
global num
num=0
for j in range(calling_num):
    for i in range(called_num):
        root = etree.fromstring(temp_body)
        starttime=root.cssselect("service-Delivery-Start-Time-Stamp")
        starttime[0].text="18101717"+ str(random.randint(10, 10))+str(random.randint(10, 59))+"+0800"
        iMS_id=root.cssselect("iMS-Charging-Identifier")
        iMS_id[0].text="sypsbc2bhw.194.a6c4.201604160341"+str(random.randint(10, 59))

        num=num+1
        myRecord="\n<!--IMSRecord"+str(num)+"------------------------------------------>\n"
        if typecall==0:
            # roleofNode=root.cssselect("role-of-Node")
            # roleofNode[0].text ="0"
            print ("主叫话单")
            callingParty=root.cssselect("calling-Party>tEL-URI")
            callingParty[0].text = "tel:+86"+str(calling[j])
            calledPartyAddress=root.cssselect("called-Party-Address>tEL-URI")
            calledPartyAddress[0].text = "tel:+86"+str(called[i])
            chargedParty=root.cssselect("charged-Party>tEL-URI")
            chargedParty[0].text = "tel:+86"+str(calling[j])
            aaa=etree.tostring(root, encoding="unicode")
            a=aaa.replace("<role-of-Node>4</role-of-Node>","<role-of-Node><originating/></role-of-Node>")
        if typecall==1:
            roleofNode=root.cssselect("role-of-Node")
            roleofNode[0].text = "1"
            callingParty=root.cssselect("calling-Party>tEL-URI")
            callingParty[0].text = "tel:+86"+str(called[i])
            calledPartyAddress=root.cssselect("called-Party-Address>tEL-URI")
            calledPartyAddress[0].text = "tel:+86"+str(calling[j])
            chargedParty=root.cssselect("charged-Party>tEL-URI")
            chargedParty[0].text = "tel:+86"+str(calling[j])
            a=etree.tostring(root, encoding="unicode")


            #print(a)
        file = r'tt.xml'
        with open(file, 'a+') as f:
            f.write(myRecord+a+'\n')
print ("该话单共生成"+str(num)+"条话单记录")
sdm={
"01":"100","02":"220","03":"311","04":"351","05":"471","06":"240","07":"431","08":"451","09":"210","10":"250",
"11":"571","12":"551","13":"591","14":"791","15":"531","16":"371","17":"270","18":"731","19":"200","20":"771",
"21":"898","22":"280","23":"851","24":"871","25":"891","26":"290","27":"931","28":"971","29":"951","30":"991",
"31":"230",
}
for z in sdm:
    if sdm[z]==str(calling_prov):
        args="VLTCG01_LNVOLTEAS01_H_"+z+"0101_20170616114649_0000"+str(br_switch)+str(typecall)+str(num)+"1.dat"

        #args="VLTCG01_LNVOLTEAS01_H_110101_20170616114649_00005588.dat"
os.system("VoLTEasn x  tt.xml "+args)
print ("生成话单文件为："+args)
def ftpput(args):
    transport = paramiko.Transport(('192.168.117.247', 22))
    transport.connect(username='mcbadm', password='McbUnix_2017')
    sftp = paramiko.SFTPClient.from_transport(transport)#如果连接需要密钥，则要加上一个参数，hostkey="密钥"
    bb=sftp.put( args,'/opt/mcb/vlt/data/incoming/'+args)#将本地的Windows.txt文件上传至服务器/root/Windows.txt
#ftpget("CDR_20160926.003")
print ( "up  "  +args)
ftpput (args)
print ("up ---------ok "  +'/opt/mcb/vlt/data/incoming/'+args)
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
    for key in cmd:
        rr=curs.execute (cmd[key])
    conn.commit()
    curs.close()                                                 #关闭cursor
    conn.close()
print ("clean "  +args)
clr_env_nm_vlt(args)
print ("clean all  ok ")
print ("----------------------------- ")
print ("select * from FILE_PROCESS_STATE where file_nm='"+args+"';")

# if typecall==1:
#     num=len(calling)
# else:
#     tmp=calling
#     calling=called
#     called=tmp
#     num=len(called)


# if len(called)==0  or len(calling)==0:
#     try:
#         sys.exit(0)
#     except:
#         print ('please put value')