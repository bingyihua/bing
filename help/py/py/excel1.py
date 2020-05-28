# -*- coding: utf-8 -*
import xlrd
import json
import re
sdm={
100:"北京",200:"广东",210:"上海",220:"天津",230:"重庆",240:"辽宁",250:"江苏",270:"湖北",280:"四川",290:"陕西",311:"河北",
351:"山西",371:"河南",431:"吉林",451:"黑龙江",471:"内蒙",531:"山东",551:"安徽",571:"浙江",591:"福建",731:"湖南",771:"广西",
791:"江西",851:"贵州",871:"云南",891:"西藏",898:"海南",931:"甘肃",951:"宁夏",971:"青海",991:"新疆",666:"石家庄"
}
jsd={
100001:"D112",100002:"D154",100003:"D155",100004:"D163",100005:"D167",100006:"D168",100007:"D181",100008:"D186",
100009:"D201",100010:"D242",100011:"D243",100012:"D244",100013:"D245",100014:"D246",100015:"D247",100016:"D248",
100017:"D249",100018:"D250",100019:"D251",100020:"D252",100021:"D253",100022:"D291",200001:"D134",200002:"D287",
200003:"D115",200004:"D233",200005:"D200",200006:"D214",200008:"D122",200009:"D124",200010:"D173",200011:"D269",
200012:"D277",200013:"D226",200014:"D278",200029:"D264",200030:"D215",200031:"D240",200032:"D296",210001:"D259",
210002:"D275",300001:"D133",400001:"D120",400002:"D126",400003:"D130",400004:"D132",400005:"D184",400006:"D254",
400007:"D271",500001:"D500",600001:"D232",600003:"D208",600004:"D208",600005:"D202",600006:"D202",710001:"D258",
710002:"D276",710003:"D284",700003:"D258",200021:"D280",700004:"D224",700005:"D303",700006:"D304",800001:"D261",
800002:"D262",800003:"D273",800004:"D281",900001:"D274",900002:"D267"
}
workbook = xlrd.open_workbook('123.xls')
# print(workbook.sheet_names())                  #查看所有sheet
booksheet = workbook.sheet_by_index(0)         #用索引取第一个sheet
#booksheet = workbook.sheet_by_name('Sheet 1')  #或用名称取sheet
#读单元格数据
cell_11 = booksheet.cell_value(0,0)
cell_21 = booksheet.cell_value(1,2)
# cell_value(1,2)表示2行3列
row_3 = booksheet.row_values(2)
# print  booksheet.nrows, booksheet.ncols
a=[];b=[]

for i in range(booksheet.nrows):
    for j in range(booksheet.ncols):
        if  booksheet.cell_value(i-1,j) == u"省公司":
            a.append (i);b.append (j)
# print booksheet.cell_value(a[-1],b[-1])
# print a[-1],b[-1]
# print booksheet.row_values(3)[5].encode('gbk')
bb={ v:k for k ,v in sdm.items()}

print (booksheet.col_values(2))
aa= {i:booksheet.cell(i,2).value for i in range(1,booksheet.nrows) if  booksheet.cell(i,2).value  in sdm.values()}
print (aa)
xh=[j for i in range(1,booksheet.nrows) for j in range(1,booksheet.ncols)  if  booksheet.cell(i,j).value=="序号"][-1]
# print ([i for i in range(1,booksheet.nrows)   if  re.match(r"\d+$", str(booksheet.cell(i,1).value)) and True or False])
# print (re.match(r"\d+$", str(booksheet.cell(i,1).value)))
# print ([str(booksheet.cell(i,1).value)  for i in range(1,booksheet.nrows)  if  re.match(r"\d+$",str(booksheet.cell(i,1).value) ) and True or False])
# print (aa1, re.match(r"\d+$", aa1) and True or False)
for i1 in booksheet.cell_value(i,1)  :
    print (i1)
print  ([ booksheet.cell(i,1).value  for i in range(1,booksheet.nrows)   if booksheet.cell(i,1).ctype==2])

#     if  aa[i]  not in bb :
#         print (aa[i])


# a1=["石家庄",2,4]

# print bb.has_key(a1[0])
# print 1,cell_21.encode('gbk')
# print  cell_21.encode('gbk')
# print (cell_21.encode('gbk'))
# aa="哈哈"
# print aa.decode('utf-8')
# print (aa.decode('utf-8'))