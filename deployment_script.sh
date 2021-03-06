#!/bin/bash

PATH=$PATH:/usr/hdp/current/kafka-broker/bin

kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic inter_transact



VERSION=`hdp-select status hadoop-client | sed 's/hadoop-client - \([0-9]\.[0-9]\).*/\1/'`
rm -rf /var/lib/ambari-server/resources/stacks/HDP/$VERSION/services/NIFI  
sudo git clone https://github.com/abajwa-hw/ambari-nifi-service.git   /var/lib/ambari-server/resources/stacks/HDP/$VERSION/services/NIFI   

service ambari restart

mkdir /home/nifi/

mkdir /home/nifi/workflow_v4/
chmod 777 -R /home/nifi/workflow_v4/
mv event_generator.py /home/nifi/workflow_v4

su hdfs
hadoop dfs -mkdir /user/nifi/
hadoop dfs -mkdir /user/nifi/raw_logs
hadoop dfs -chown -R nifi:nifi /user/nifi/
exit
