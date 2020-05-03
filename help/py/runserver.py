from flask import Flask, request, render_template
import json
import pymysql as mysql

app = Flask(__name__)
db = mysql.connect(user="root", passwd="test123",host="192.168.56.103", db="mysql", charset="utf8")
db.autocommit(True)
cur = db.cursor()

@app.route("/")
def index():
    def getdata():    
        global  tmp_time
        if tmp_time > 0 :
            sql = "select time,mem_free from stat where time <%s" %(tmp_time)
        else:
            sql = "select time,mem_free from stat"
        cur.execute(sql)
        datas = []
        for i in cur.fetchall():
            datas.append( i[1])
    return render_template("mb.html")

tmp_time = 0

@app.route("/data")
def getdata():
    '''第一次查询全量数据，后面只查询增量数据'''
    global  tmp_time
    if tmp_time > 0 :
        sql = "select time,mem_free from stat where time <%s" %(tmp_time)
    else:
        sql = "select time,mem_free from stat"
    cur.execute(sql)
    datas = []
    for i in cur.fetchall():
        datas.append( i[1])

    #if len(datas) > 0 :
        #tmp_time = datas[-1][0]
    #print (tmp_time)
    return json.dumps(datas)


if __name__ == "__main__":
    getdata()
    app.run(host='0.0.0.0',port=8888,debug=True)