#!/bin/bash

set -ex

DIR=/home/kafka
#VERSION=0.11.0.3
VERSION=2.3.0

sudo apt-get install -y default-jre
sudo useradd kafka -m || [ $? -eq 9 ]
sudo -u kafka mkdir -p $DIR/config
cd $DIR
#echo 'ruok' | telnet localhost 2181
#[ -f kafka_2.11-$VERSION.tgz ] || sudo -u kafka wget "http://mirror.metrocast.net/apache/kafka/$VERSION/kafka_2.11-$VERSION.tgz" -O kafka_2.11-$VERSION.tgz && \
#	echo "d38caaa80f43d02dcc8bc453fbf71e8d609249731583556fdd991dcb09ff342d0ec855896ff76875cea48a471cc95bda9174bf3f3507696f243e72e5e456c584 kafka_2.11-$VERSION.tgz" |sha512sum -c
#sudo -u kafka tar -xzf kafka_2.11-$VERSION.tgz --strip 1
[ -f kafka_2.12-$VERSION.tgz ] || sudo -u kafka wget "http://mirror.metrocast.net/apache/kafka/$VERSION/kafka_2.12-$VERSION.tgz" -O kafka_2.12-$VERSION.tgz && \
	echo "a5ed591ab304a1f16f7fd64183871e38aabf814a2c1ca86bb3d064c83e85a6463d3c55f4d707a29fc3d7994dd7ba1f790b5a6219c6dffdf472afd99cee37892e  kafka_2.12-$VERSION.tgz" |sha512sum -c
sudo -u kafka tar -xzf kafka_2.12-$VERSION.tgz --strip 1
sudo /bin/bash -c "echo -e \"\ndelete.topic.enable = true\nnum.partitions=8\n\" >> $DIR/config/server.properties"

#a5ed591ab304a1f16f7fd64183871e38aabf814a2c1ca86bb3d064c83e85a6463d3c55f4d707a29fc3d7994dd7ba1f790b5a6219c6dffdf472afd99cee37892e  kafka_2.12-2.3.0.tgz

if [ -n "$DOCKER_BUILD" ]; then
	exit
fi

sudo -u kafka /bin/bash -c "nohup $DIR/bin/zookeeper-server-start.sh /home/kafka/config/zookeeper.properties >$DIR/zookeeper.log 2>&1 &"
sudo -u kafka /bin/bash -c "nohup $DIR/bin/kafka-server-start.sh /home/kafka/config/server.properties >$DIR/kafka.log 2>&1 &"
sleep 2

#echo "Hello, World" | ~/bin/kafka-console-producer.sh --broker-list localhost:9093 --topic TutorialTopic > /dev/null
#~/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic TutorialTopic --from-beginning
