#!/bin/bash
#Alternative way to query the data with mbpoll
echo "get voltages, current and power" 
mbpoll -1 -0 -a 1 -m rtu -b 115200 -P none -d 8 -t 4 -r 263 -c 6  /dev/ttyUSB0

echo "get day production"
mbpoll -1 -0 -a 1 -m rtu -b 115200 -P none -d 8 -t 4 -r 300 -c 1  /dev/ttyUSB0
echo "get month year production"
mbpoll -1 -0 -a 1 -m rtu -b 115200 -P none -d 8 -B -t 4:int -r 301 -c 3  /dev/ttyUSB0
