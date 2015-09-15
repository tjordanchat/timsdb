#!/bin/bash
set -x
date
export INAME=$( basename $( pwd ) | tr '[A-Z]' '[a-z]' )
git clone git@192.168.10.1:build/tibco_build_files.git
cd tibco_build_files
git checkout develop
cd ..
sudo docker build --rm .
export IMAGE=$( sudo docker images -q | sed -n 1p )
export CONTAINER=$( sudo docker run --privileged -itd "$IMAGE" bash )
sudo cat ~jenkins/.ssh/id_rsa | sudo docker exec -i "$CONTAINER" sh -c 'cat > /root/.ssh/id_rsa'
sudo docker exec -i $CONTAINER bash -c 'chmod 600 /root/.ssh/id_rsa'
sudo docker exec -i $CONTAINER bash -c 'echo Yes | git clone git@10.156.74.122:autocheckin/AutoCheckin.git'
sudo docker exec -i $CONTAINER bash -c '/root/autocheckin_build'
date
