#!/bin/bash

sudo apt-get update

# install java 1.7
sudo apt-get install openjdk-7-jdk -y
sudo update-java-alternatives -s java-1.7.0-openjdk-amd64

# install logstash
pushd /opt
curl -O https://download.elastic.co/logstash/logstash/logstash-2.2.2.tar.gz
tar zxvf logstash*.tar.gz
rm -rf logstash*.tar.gz
popd
cp extras /opt/logstash*/patterns/

# install elasticsearch
pushd /opt
curl -O https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.2.0/elasticsearch-2.2.0.zip
tar zxvf elasticsearch*.tar.gz
rm -rf elasticsearch*.tar.gz
popd

# install kibana
pushd /opt
wget https://download.elastic.co/kibana/kibana/kibana-4.4.2-linux-x64.tar.gz
tar zxvf kibana*.tar.gz
rm -rf kibana*.tar.gz
popd

# setup run_elk.sh
CONF_PATH=`pwd`
sed -e "s#{CONF_PATH}#$CONF_PATH#g" \
    run_elk_template.sh | \
    tee run_elk.sh > /dev/null
chmod +x run_elk.sh

# Run elk stack
./run_elk.sh
