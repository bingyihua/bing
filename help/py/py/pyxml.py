import lxml.etree as ET
import openpyxl
import re
url = 'test.xml'
tree = ET.parse(url)
lncrna ="RNA"
abstract = tree.xpath('//try')
string = abstract[0].text
if(abstract):
abstract[0].text = anotherString
print (abstract[0].text,anotherString)
tree.write('test.xml', encoding='UTF-8', pretty_print=True)
print(help(tree))