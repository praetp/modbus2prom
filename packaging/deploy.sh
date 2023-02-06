#!/bin/bash
cd "$(dirname "$0")"
rsync -av --delete ../src/* ../conf/registers_saj.modbus systemd spetsnaz@shumeipai.local:/opt/homestuff/modbus2prom/
