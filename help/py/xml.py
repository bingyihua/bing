# -*- coding: utf-8 -*-
from lxml import etree
xml_string = u"""
<urlset>
<url>
<display>
<name><search>123</search><li>222123</li></name>
<address>zhongguo</address>
<search>1123</search>
<search>123</search>
<li>1231</li>
<li>123</li>
</display>
</url>
</urlset>
"""

root = etree.fromstring(xml_string)
url_tag = root.find(".//search")
url1 = root.findall(".//search")[2]
for url in root:
    url2 = url.findall("display/search")[0]
    print(url2.text)
#print (root.findall("display/search")[1].text) #会报错，如果使用精确查找display/search就用for url in root
print(root.cssselect("li")[0].text)
abc=root.cssselect("name>li")[0]
abc.text="33333"

print (len(root.findall(".//search")))
print (len(root.find(".//search")))
if url1.text == "123":
    url_tag.text = "456"
    url1.text = "456"
    #url2.text = "456"
a=etree.tostring(root, encoding="unicode")
print( a)