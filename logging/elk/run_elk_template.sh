#!/bin/bash

ELK_LOGS="/var/log/elk"
mkdir -p $ELK_LOGS

# Run elasticsearch
service elasticsearch start
sleep 10

# Run logstash
service logstash start
sleep 3

# Run kibana
pushd /opt/kibana* > /dev/null 2>&1
python -m SimpleHTTPServer > $ELK_LOGS/kibana.log 2>&1 &
popd > /dev/null 2>&1
