#!/home/mcbadm/cuiyb/python27/bin/python27
# -*- coding: utf-8 -*-

def work():                                  #���庯��
    for i in range(5):
        print("i=", i)
 
        for j in range(5):
            print("--j=", j)
 
            for k in range(5):
 
                if k<2:
                    print("------>k=", k)
                else:
                    return i,j,k             
print (work())
count=0
for i in range(5):
   
    while count < 6:
        print("����"+str(count)+"��...")
        count+=1
        if count==2:
            print "hahah"+str(count)
    if count==2:
        break
    else:
        print "clr +++"
print"keep going..."

