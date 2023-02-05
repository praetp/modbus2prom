#!/bin/bash
#maybe we should look into using python virtualenv
modbus -r registers_saj.modbus -P n -B be -p 1 -b 115200 /dev/ttyUSB0 \*
