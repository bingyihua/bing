#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-
import os
aa="""1   Record-Type
2   Retransmission
3   SIP-Method
4   Role-of-Node
5   Node-Address
6   Session-ID
7   Calling-Party
8   List-of-Calling-Party-Address
9   Called-Party-Address
10  Service-Request-Time-Stamp
11  Service-Delivery-Start-Time-Stamp
12  Service-Delivery-End-Time-Stamp
13  Record-Opening-Time
14  Record-Closure-Time
15  Inter-Operator Identifiers[1]
16  Originating-IOI [2]
17  Terminating-IOI [2]
18  Local-Record-Sequence-Number
19  Record-Sequence-Number
20  Cause-For-Record-Closing
21  IMS-Charging-Identifier
22  SDP-Media-Identifier
23  List-Of-SDP-Media-Components [1]
24  SDP-Session-Description [2]
25  SDP-Type[2]
26  SIP-Request-Time-Stamp [2]
27  SIP-Response-Time-Stamp [2]
28  SDP-Media-Components [2]
29  SDP-Media-Name [3]
30  SDP-Media-Descriptions [3]
31  GPRS-Charging-Id [3]
32  Media-Initiator-Flag [2]
33  GGSN-Address
34  Service-Reason-Return-Code
35  Access-Network-Information
36  CS-Location-Information
37  MscNumber
38  Location-Area
39  Cell-Identification
40  Requested-Party-Address
41  Charged-Party
42  Online-Charging-Flag
43  Duration
44  Service-Identity
45  IMS-Visited-Network-Identifier
46  TADS-Indication
47  Initial-IMS-Charging-Identifier
48  Service-Interact-Info [1]
49  Executed-Service [2]"""
open('ziduan_tmp', 'w').write(aa)

#py -> shell
#os.environ['var']=str(aa)
#os.system("echo  $var")


var=os.popen("awk '{print $1}' ziduan_tmp").read( ).split('\n')[0:-1]

var2=os.popen("awk '{print $2,$3 }' ziduan_tmp").read( ).split('\n')[0:-1]
#print var
#print var2
#print dict(map(lambda x,y:[int(x),y], var,var2))
#print dict(zip(var,var2))
bb="""69||BYE|1|csvoltetas3bhw.voltetas.hn.chinamobile.com|hIV7-oFEzT3FFwjZ1OjIMw..|tel:+8618720633999|tel:+8618720633999|tel:+8618207321169|20161230043149+0800|20161230043154+0800|20161230043225+0800|20161230043154+0800|20161230043225+0800|||hn.chinamobile.com|265709721||0|36ceca06fdf22cf520a743dd6a6e62c0.3692032309.7871990.107|0|||1|20161230043149+0800|20161230043154+0800|||||||0|3GPP-E-UTRAN;utran-cell-id-3gpp=460009398BC2ED00;sbc-domain=lzpsbc3bhw.0939.gs.chinamobile.com;ue-ip=[2409:880D:A010:6225:809:E17E:23D8:245D];ue-port=49918;network-provided||||||tel:+8618207321169|0|31||"lzpsbc3bhw.gs.ims.mnc000.mcc460.3gppnetwork.org"|||||"""
#for ss in  ["|".join(i["|".join(i)  for i in bb ]      )  for i in bb ]:print ss
for ss in [11,22,33]:
    sb=3
    os.environ['var']=str(bb)
    os.system("echo  $var|awk -F '|' -vOFS='|'  '{$"+str(sb)+"=\""+str(ss)+"\"}1'")
os.system("ls")