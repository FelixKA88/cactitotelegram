#!/bin/bash -x
#change directory to telecac path
cd /root/telecac;
#run sql.sh to run sql query, insert to report.txt and run sendtotelegram.py
./sql.sh &>/dev/null
