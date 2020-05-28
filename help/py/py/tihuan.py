import re  
  

  
def str_test():  
    str_list=['We are family!!!', '00 11 22 33 44 55 66 77 88 99',  
              'Trouble is a friend!!!Trouble is a friend!!!', 'LoveLoveLove']  
    str_dict={  
        '!!!':'$$$',  
        ' ':'@',  
        'T':'t',  
        'L':'&'  
    }  

    str_list1=str_list  
    res_list=[]  
    for one_str in str_list1:  
        for key in str_dict:  
            one_str = one_str.replace(key, str_dict[key])  
        res_list.append(one_str)  
    print '**************replace********************'  
    print str_list1  
    print res_list  
  

    str_list2=str_list  
    res_list=[]  
    pattern_rule=re.compile(r'!!!')  
    for one_str in str_list2:  
        one_str = re.sub(pattern_rule, '$$$', one_str)  
        res_list.append(one_str)  
    print '**************sub*******************'  
    print str_list2  
    print res_list  
  

    str_list3=str_list  
    res_list=[]  
    for one_str in str_list3:  
        one_str=one_str.strip('!!!')  
        res_list.append(one_str)  
    print '**************strip******************'  
    print str_list3  
    print res_list  
str_test()