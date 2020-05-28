
# -*- coding: UTF-8 -*-
#import unittest
import os
import time
from xml.dom import minidom
import  xml.dom.minidom

path = os.path.abspath('.')
data_path = os.path.join(path,'test.xml')
DOMTree = minidom.parse(data_path)
data = DOMTree.documentElement

def get_attrvalue(node, attrname):
    return node.getAttribute(attrname)
def get_data_vaule(style, typename, typevalue, valuename):
    nodelist = data.getElementsByTagName(style)

    for node in nodelist:
        if typevalue == node.getAttribute(typename):
            node_name = node.getElementsByTagName(valuename)
            value = node_name[0].childNodes[0].nodeValue
            print (value)
            return value
    return
text = get_data_vaule('account','type','createText','test')
print(text)