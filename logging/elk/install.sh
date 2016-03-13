#!/bin/bash

INTERNAL_IP=`ip addr show eth1 | grep 'inet' | grep -v inet6 | cut -d ' ' -f 6 | cut -d '/' -f 1`

sudo apt-get update

# install java 1.7
sudo apt-get install openjdk-7-jdk -y
sudo update-java-alternatives -s java-1.7.0-openjdk-amd64

# install logstash
pushd /opt
curl -O https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.2.2-1_all.deb
dpkg -i logstash_2.2.2-1_all.deb
rm -rf logstash_2.2.2-1_all.deb
popd
cp -v confs/* /etc/logstash/conf.d/
pushd /etc/logstash/conf.d/
sed -e "s#{INTERNAL_IP}#$INTERNAL_IP#g" \
    input.conf.template | \
    tee input.conf > /dev/null
popd

# install elasticsearch
pushd /opt
curl -O https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.2.0/elasticsearch-2.2.0.deb
dpkg -i elasticsearch-2.2.0.deb
rm -rf elasticsearch-2.2.0.deb
popd

# install kibana
pushd /opt
wget https://download.elastic.co/kibana/kibana/kibana-4.4.2-linux-x64.tar.gz
tar zxf kibana*.tar.gz
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
