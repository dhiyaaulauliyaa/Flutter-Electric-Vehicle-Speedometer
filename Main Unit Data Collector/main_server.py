from websocket_server import WebsocketServer
import time
import json
import data_logger
from datetime import datetime

import obd_reader
import obd
from obd import OBDStatus

numOfData = 0
speed = 0
rpm = 0
temp = 0

# Function to send data
def send_data(speed, rpm):
    # send message
    data = {"speed" : str(speed), "rpm" : str(rpm), "temp" : str(temp)}
    jsonData = json.dumps(data)
    server.send_message_to_all(jsonData)

# Called for every client connecting (after handshake)
def new_client(client, server):
    print("New client connected and was given id %d" % client['id'])
    send_data(0,0)
    # server.send_message_to_all("Hey all, a new client has joined us")


# Called for every client disconnecting
def client_left(client, server):
    global numOfData
    print("On Data: %d | Client(%d) disconnected" % (numOfData, client['id']))
    numOfData = 0

    data_logger.dataSave()

# Called when a client sends a message
def message_received(client, server, message):
    global obdConnection
    global numOfData

    # get data from OBD
    rawData = obd_reader.get_OBD_data(obdConnection)
    jsonData = json.dumps(rawData)

    data = json.loads(jsonData)
    speed = data['speed']
    rpm = data['rpm']
    temp = data['temp']

    # timestamp
    x = datetime.now()
    micros = x.microsecond

    # send message
    server.send_message_to_all(jsonData)
    print("Sent   : {0} | Speed: {1} | RPM: {2} | Temp: {3} | Micros: {4}".format(numOfData, speed, rpm, temp, micros))

    # data logger
    data_logger.dataLogger(speed, rpm, temp, numOfData)

    numOfData += 1
    time.sleep(0.001)

# Establishing connection to OBD
obdConnection = obd_reader.connect_to_OBD()

if (obdConnection.status() == OBDStatus.CAR_CONNECTED):
    print("Waiting for Websocket Connection")
    # Establishing connection from server
    port = 7500
    server = WebsocketServer(port, host='192.168.43.237')
    server.set_fn_new_client(new_client)
    server.set_fn_client_left(client_left)
    server.set_fn_message_received(message_received)

    server.run_forever()

else:
    print("Connecting to OBD failed. Check your hardware.")
