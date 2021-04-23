import xlwt
import time
from datetime import datetime

numOfConnection = 0

wb = xlwt.Workbook()
ws = wb.add_sheet('Main Data', cell_overwrite_ok=True)

def dataLogger(speed,rpm,temp,numOfData):
    global ws

    # Header
    if(numOfData == 0):
        ws.write(0,0,"No")
        ws.write(0,1,"Speed")
        ws.write(0,2,"RPM")
        ws.write(0,3,"Temp")
        ws.write(0,4,"Tanggal")
        ws.write(0,5,"Jam")
        ws.write(0,6,"Menit")
        ws.write(0,7,"Detik")
        ws.write(0,8,"Microsecs")
        
    #print("Write Header")

    # Urutan Data
    ws.write(numOfData+1,0,numOfData)
    
    # Speed
    ws.write(numOfData+1,1,"{0}".format(speed))

    # RPM
    ws.write(numOfData+1,2,"{}".format(rpm))

    # TEMP
    ws.write(numOfData+1,3,"{}".format(temp))

    # Tanggal Waktu
    x = datetime.now()
    thn = x.year
    bln = x.month
    hari = x.day
    jam = x.strftime("%H")
    menit = x.strftime("%M")
    detik = x.strftime("%S")
    micros = x.microsecond
    ws.write(numOfData+1,4,"0{0}/{1}".format(bln, hari))
    ws.write(numOfData+1,5,"{0}".format(jam))
    ws.write(numOfData+1,6,"{0}".format(menit))
    ws.write(numOfData+1,7,"{0}".format(detik))
    ws.write(numOfData+1,8,"{0}".format(micros))

    print("Writing: {0} | Speed: {1} | RPM: {2} | Temp: {3} | Micros: {4}".format(numOfData, speed, rpm, temp, micros))

def dataSave():
    # Tanggal Waktu
    x = datetime.now()
    bln = x.month
    hari = x.day
    jam = x.strftime("%H")
    menit = x.strftime("%M")
    detik = x.strftime("%S")
    
    
    global numOfConnection
    numOfConnection += 1
    namaFile = "0{0}{1} | {2}{3}{4} | [".format(bln, hari,jam, menit, detik) + str(numOfConnection) + '].xls'

    global wb
    wb.save(namaFile)
    print("Data saved")
