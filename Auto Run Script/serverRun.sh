#!/bin/bash
echo "Server detected not running. Starting Server at $(date)." >> ~/Run_Server/runserver.log

coproc bluetoothctl
echo -e 'connect 00:0D:18:3A:67:89\ninfo 00:0D:18:3A:67:89\nexit' >&${COPROC[1]}

sudo rfcomm release rfcomm0
sudo rfcomm bind rfcomm0 00:0D:18:3A:67:89

python3 /home/pi/Documents/Skripsi/3/main_server.py 
