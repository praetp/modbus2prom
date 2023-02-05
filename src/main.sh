#!/bin/bash
#install modbus first with pip install modbus (https://github.com/favalex/modbus-cli)
#install gawk 

set -euo pipefail
shopt -s inherit_errexit

INTERVAL=5
DESTDIR=/opt/homestuff/node_exporter/prometheus-dropzone

TMPFILE=$(mktemp /tmp/modbus_prom.XXXXXXXX)
[ -d ${DESTDIR} ] || mkdir ${DESTDIR}
while :
do
    ./getdata_modbus.sh | tail -n +2 | gawk -f convert.awk > ${TMPFILE}
    mv ${TMPFILE} ${DESTDIR}/modbus.prom
    sleep ${INTERVAL}
done
