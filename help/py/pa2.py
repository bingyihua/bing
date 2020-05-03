import requests
from bs4 import BeautifulSoup
from urllib.parse import quote
import getpass
filename = 'cookie_csdn.txt'
#声明一个MozillaCookieJar对象实例来保存cookie，之后写入文件
cookie = http.cookiejar.MozillaCookieJar(filename)

#利用urllib2库的HTTPCookieProcessor对象来创建cookie处理器
handler = urllib.request.HTTPCookieProcessor(cookie)
#通过handler来构建opener
opener = urllib.request.build_opener(handler)

loginurl = "https://passport.csdn.net/account/login?from=http://my.csdn.net/my/mycsdn"

#登陆前准备：获取lt和exection
response = opener.open(loginurl)
soup = BeautifulSoup(response.read(), "lxml")
for input in  soup.form.find_all("input"):
    if input.get("name") == "lt":
        lt = input.get("value")
    if input.get("name") == "execution":
        execution = input.get("value")
#post信息
#
values = {
        "username":"623545558@qq.com",
        "password":"cyb326598",
        "lt":lt,
        "execution":execution,
        "_eventId":"submit"
    }
postdata = urllib.parse.urlencode(values).encode('utf-8')

opener.addheaders = [("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0")]#模拟登录,保存cookie到cookie.txt中



result = opener.open(loginurl, postdata)

cookie.save(ignore_discard=True, ignore_expires=True)
#登陆后我们随意跳转到博客
url = "http://blog.csdn.net/cuiyubing819"
result = opener.open(url)
