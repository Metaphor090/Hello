import pymysql
import time
import datetime

from os import path
from urllib.parse import urlparse
import json
 
from socket import *
from time import ctime
#TCP server
GODKEY = '028db9f5-f094-4f3b-b770-8ee6a859af33'
HOST = ''
PORT = 17173
BUFSIZ=1024
ADDR = (HOST,PORT)

def NormalConn(imei,keycode):
    # 连接database
    conn = pymysql.connect(
        host='127.0.0.1',
        port= 3306,
        user='root',password='woaiwoziji090',
        database='FgoDatabase',
        charset='utf8')


    # 得到一个可以执行SQL语句的光标对象
    cursor = conn.cursor()  # 执行完毕返回的结果集默认以元组显示
    # 得到一个可以执行SQL语句并且将结果作为字典返回的游标
    #cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)
    # 定义要执行的SQL语句 #注意：charset='utf8' 不能写成utf-8

    #Create Tables
    #sql = "CREATE TABLE RegKeyCode(id INT auto_increment PRIMARY KEY,purekeycode CHAR(36) NOT NULL UNIQUE,KeyType INT);"
    #presql2 = "CREATE TABLE PayUsers(id INT auto_increment PRIMARY KEY,keycode CHAR(36) NOT NULL UNIQUE,imeicode CHAR(15) NOT NULL UNIQUE,regtime datetime,deadtime datetime);"
    
   

    #Insert Test Data   % ("fa36a2eb-4e03-4ba6-a2c8-c723bf18e7d7")
    #UUID = "fa36a2eb-4e03-4ba6-a2c8-c723bf18e7d7"
    #sql = "insert into RegKeyCode(purekeycode) values (%s)"
    #dt = time.time()    #毫秒级时间戳
    dt_now=time.strftime("%Y-%m-%d %H:%M:%S")
    #Insert
    UerInfo = {
        'keycode':"38abc950-2fc7-4642-a1f3-5cb1d8487739",
        'imeicode' : "865166023249272",
        'regtime' : dt_now,
        'deadtime' : dt_now,

    }

    KeyInfo = {
        'keycode':"cc014db6-f777-4046-a47e-7598bcf9d871",
        'keytype':1,


    }

    #sql = "insert into RegKeyCode(purekeycode,keytype) values (%s,%s)"
    #sql = "insert into PayUsers(keycode,imeicode,regtime,deadtime) values (%s,%s,%s,%s)"
    #Delete
    

    #alter

  
    #find
    FindUnlockSql = "SELECT * FROM PayUsers WHERE keycode=%s and imeicode=1" 
    UnlockSql = "UPDATE PayUsers SET keycode=%s,imeicode=%s"
    EnterSql = "SELECT * FROM PayUsers WHERE keycode=%s and imeicode=%s" 
    FindKeySql = "SELECT * FROM RegKeyCode WHERE purekeycode=%s"
    RegNewUserSql = "insert into PayUsers(keycode,imeicode,regtime,deadtime) values (%s,%s,%s,%s)"
    FindimeiSql = "SELECT * FROM PayUsers WHERE imeicode=%s"
    AddOldUserSql = "UPDATE PayUsers SET keycode=%s,deadtime=%s WHERE imeicode=%s"
    DelPureKeycodeSql = "DELETE from RegKeyCode WHERE purekeycode=%s"
    # 执行SQL语句
    cursor.execute(EnterSql,(keycode,imei))
    # 获取所有记录列表
    results = cursor.fetchall()
    print(len(results))
    if len(results) == 0:
        print("user  or keycode exchange")
        cursor.execute(FindKeySql,keycode)
        results = cursor.fetchall()
        if len(results) == 0:
             #这里检测一下是否是解锁需求
            cursor.execute(FindUnlockSql,keycode)
            results = cursor.fetchall()
            if len(results) == 0:
                print("[404]not allow!")
            
                return 404 
            elif len(results) == 1:#如果查询到那么就是解锁操作
                print("[200]Unlock!")
                cursor.execute(UnlockSql,(keycode,imei))
                return 200
        elif len(results) == 1:
            print("new user or user add")
            #record timetype + deadtime
            for row in results:
                id = row[0]
                purekeycode=row[1]
                KeyType=row[2]
            
            #insert userinfo  reg or add
            cursor.execute(FindimeiSql,(imei))
            results = cursor.fetchall()
            if len(results) == 0: #not find so reg
                print('not find so reg')
                BaseTime = datetime.datetime.now()
                RetTime = FromTimeTypeToTimeDel(BaseTime,KeyType)
                cursor.execute(RegNewUserSql,(purekeycode,imei,BaseTime,RetTime))
                #del purekeycode
                cursor.execute(DelPureKeycodeSql,purekeycode)
                conn.commit()
            else: #find so add
                for row in results:
                    id = row[0]
                    oldkeycode=row[1]
                    imei=row[2]
                    regtime = row[3]
                    deadtime = row[4]
                print('find so add')
                #curtime
                if (deadtime - datetime.datetime.now()) <= 0:

                    BaseTime = datetime.datetime.now()
                else:
                    BaseTime = deadtime
                RetTime = FromTimeTypeToTimeDel(BaseTime,KeyType)
                print('Ret time:' + str(RetTime))
                cursor.execute(AddOldUserSql,(keycode,RetTime,imei))
                #del purekeycode
                cursor.execute(DelPureKeycodeSql,keycode)
                conn.commit()
            print("[200]allow!")
            return RetTime
        else:
            print("multuser exist")
            return 5
    elif len(results) == 1:
        print("user exist")
        for row in results:
            id = row[0]
            keycode = row[1]
            imeicode = row[2]
            regtime = row[3]
            deadtime = row[4]
            # 打印结果
            print ("id=%s,keycode=%s,imeicode=%s,regtime=%s,deadtime=%s" % \
                    (id,keycode, imeicode,regtime,deadtime))

        #check time 
        #if deadtime < regtime  timeout 
        #get current time
        NowTime = datetime.datetime.now()
        print((deadtime - NowTime))
        if (deadtime - NowTime).days < 0:
            print("[404]not allow!")
            return 404
        else:
            print("[200]User goto!")
            return deadtime
    else:
        print("multuser exist")
        return 5
   


    # 执行SQL语句
    #cursor.executemany(sql, data)
    #cursor.execute(sql)
    #cursor.execute(sql,(UerInfo['keycode'],UerInfo['imeicode'],UerInfo['regtime'],UerInfo['deadtime']))
    #cursor.execute(sql,(KeyInfo['keycode'],KeyInfo['keytype']))
    #cursor.execute(sql2)
    # 提交，不然无法保存新建或者修改的数据
    #conn.commit()
    # 关闭光标对象
    cursor.close()
    
    # 关闭数据库连接
    conn.close()

#1 day 2 week 3 month 4 3months 5 half year 6  year 7 all
def FromTimeTypeToTimeDel(BaseTime,TimeType):
    print('TimeType:' + str(TimeType))
    if TimeType == 1:
        BaseTime = BaseTime + datetime.timedelta(days=1)
        
    elif TimeType == 2:
        BaseTime = BaseTime + datetime.timedelta(days=7)
    elif TimeType == 3:
        BaseTime = BaseTime + datetime.timedelta(weeks=4)
    elif TimeType == 4:
        BaseTime = BaseTime + datetime.timedelta(weeks=12)
    elif TimeType == 5:
        BaseTime = BaseTime + datetime.timedelta(days=183)
    elif TimeType == 6:
        BaseTime = BaseTime + datetime.timedelta(days=365)
    elif TimeType == 7:
        BaseTime = BaseTime + datetime.timedelta(days=3650)
    
    return BaseTime


def run():
   
    
    tcpSerSock = socket(AF_INET,SOCK_STREAM)
    tcpSerSock.bind(ADDR)
    tcpSerSock.listen(5)

    while True:
        print('waiting for connection...')
        tcpCliSock,addr = tcpSerSock.accept()
        print('...connected from:',addr)
        
        while True:
            try:
                data = tcpCliSock.recv(BUFSIZ)
            except ConnectionResetError:
                break
            print(data.decode())
            if not data or data.decode()=='bye':
                break
            #do data 
            dataList = data.decode().split("|")
            imei = dataList[0]
            keycode = dataList[1]
            ConnRet = NormalConn(imei,keycode)#return 404|not allow 200|allow 5|don't know   
            #return data
            try:
                tcpCliSock.send(str(ConnRet).encode())
            except BrokenPipeError:
                pass
		
         
               
        tcpCliSock.close()
        print('close current link')


if __name__ == '__main__':
    run()
    imei = "111"
    











#==============================================server================================================



#=============================database===============================================================
