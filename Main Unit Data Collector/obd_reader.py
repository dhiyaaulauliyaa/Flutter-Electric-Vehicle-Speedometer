import sys
import obd
import time
import json
from obd import OBDStatus

connect_attempt = 0

def connect_to_OBD():
    global connect_attempt
    connecting = True
    while (connecting):
        try:
            print("")
            print("Establishing connection to OBD")
            connection = obd.OBD()
            if (connection.status() == OBDStatus.CAR_CONNECTED):
                print("OBD Connected!")
                print("")
                connecting = False
                return connection
        except:
            if(connect_attempt>10):
                print("Attempt {0} has been failed. Check hardware.".format(connect_attempt))
                break

            print("Connecting failed, trying again. Attempt: {0}".format(connect_attempt))
            connect_attempt += 1

def get_OBD_data(connection):
    speed = obd.commands.SPEED
    rpm = obd.commands.RPM
    temp = obd.commands.COOLANT_TEMP

    speedResponse = connection.query(speed)
    rpmResponse = connection.query(rpm)
    tempResponse = connection.query(temp)

    finalSpeed = speedResponse.value.magnitude
    finalRPM = rpmResponse.value.magnitude
    finalTEMP = tempResponse.value.magnitude

    data = {"speed" : str(finalSpeed), "rpm" : str(finalRPM), "temp" : str(finalTEMP)}
    return data
