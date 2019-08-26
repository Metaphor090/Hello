import pymysql
import uuid
import datetime


# 创建文件,msg即要写入的内容
def create__report(msg, timeInfo):
    report_path = "RegKeyCode" + str(timeInfo)
    f = open(report_path, "a")
    f.write(msg + "\n")
    f.close()


def MakeKeyCode(keynum, keytype):
    DataList = []
    NowTime = datetime.datetime.now()
    # record keynum make to write to file and upload
    for basenum in range(keynum):
        print(uuid.uuid4())
        MakeLineStr = str(uuid.uuid4()) + "|" + keytype + "\n"

        # save temp data
        DataList.append(MakeLineStr)
        # write file
        create__report(MakeLineStr, NowTime)

    return DataList


def UploadKeyCode(DataList):
    # 连接database
    conn = pymysql.connect(
        host='127.0.0.1',
        port=3306,
        user='root', password='woaiwoziji090',
        database='FgoDatabase',
        charset='utf8')

    # 得到一个可以执行SQL语句的光标对象
    cursor = conn.cursor()  # 执行完毕返回的结果集默认以元组显示
    # 得到一个可以执行SQL语句并且将结果作为字典返回的游标
    # cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)
    # 定义要执行的SQL语句 #注意：charset='utf8' 不能写成utf-8

    # Create Tables
    # sql = "CREATE TABLE RegKeyCode(id INT auto_increment PRIMARY KEY,purekeycode CHAR(36) NOT NULL UNIQUE,KeyType INT);"
    # presql2 = "CREATE TABLE PayUsers(id INT auto_increment PRIMARY KEY,keycode CHAR(36) NOT NULL UNIQUE,imeicode CHAR(15) NOT NULL UNIQUE,regtime datetime,deadtime datetime);"

    KeyInfo = {
        'purekeycode': "cc014db6-f777-4046-a47e-7598bcf9d871",
        'keytype': 1,

    }

    InsertRegCodeSql = "INSERT into RegKeyCode(purekeycode,keytype) values(%s,%s)"
    # 执行SQL语句
    for DataValue in DataList:
        DataElement = DataValue.split("|")
        cursor.execute(InsertRegCodeSql, (DataElement[0], DataElement[1]))
        conn.commit()

    # 关闭光标对象
    cursor.close()

    # 关闭数据库连接
    conn.close()

def UnlockKeyCode(code):
    # 连接database
    conn = pymysql.connect(
        host='127.0.0.1',
        port=3306,
        user='root', password='woaiwoziji090',
        database='FgoDatabase',
        charset='utf8')

    # 得到一个可以执行SQL语句的光标对象
    cursor = conn.cursor()  # 执行完毕返回的结果集默认以元组显示
    # 得到一个可以执行SQL语句并且将结果作为字典返回的游标
    # cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)
    # 定义要执行的SQL语句 #注意：charset='utf8' 不能写成utf-8

    # Create Tables
    # sql = "CREATE TABLE RegKeyCode(id INT auto_increment PRIMARY KEY,purekeycode CHAR(36) NOT NULL UNIQUE,KeyType INT);"
    # presql2 = "CREATE TABLE PayUsers(id INT auto_increment PRIMARY KEY,keycode CHAR(36) NOT NULL UNIQUE,imeicode CHAR(15) NOT NULL UNIQUE,regtime datetime,deadtime datetime);"
    UnlockCodeSql = "update PayUsers set IMEICode=1 where IMEICode=%s"
    cursor.execute(UnlockCodeSql, code)
    conn.commit()

    # 关闭光标对象
    cursor.close()

    # 关闭数据库连接
    conn.close()

if __name__ == '__main__':
    print("====================\n")
    print("FgoServer内部操作面板\n")
    print("1.keycode生成\n")
    print("2.通过解绑文件解绑\n")
    print("====================\n")
    print('Please Select your choices:\n')
    SelectedType = input()
    if SelectedType == "1":
        print('Please input num and type:\n')
        print('num:')
        num = input()
        print('type:')
        numtype = input()
        DataList = MakeKeyCode(int(num), numtype)
        UploadKeyCode(DataList)
    elif SelectedType == "2":
        file = open("UnlockKey.txt")
        while 1:
            line = file.readline()
            if not line:
                break
            else
                #read a line
                UnlockKeyCode(line)
