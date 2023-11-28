#/bin/bash

#install commands:

git clone https://github.com/fatman00/network-api.git

cd network-api
sed -i 's/8000:8000/8001:8000/g' docker-compose.yml

nano app/device_inventory.yaml 

DEVNET-IOSXE:
  ip: sandbox-iosxe-latest-1.cisco.com
  username: admin
  password: C1sco12345
  device_type: ios

CAT8Kv:
  ip: 198.18.134.49
  username: admin
  password: C1sco12345
  device_type: ios

sudo docker-compose up -d

cd ..

#install and setup netbox

git clone -b release https://github.com/netbox-community/netbox-docker.git
cd netbox-docker
tee docker-compose.override.yml <<EOF
version: '3.4'
services:
  netbox:
    ports:
      - 8000:8080
EOF

sudo docker-compose up -d
sudo docker compose exec netbox /opt/netbox/netbox/manage.py createsuperuser

cd ..
#install and run Node-Red

mkdir node-red
cd node-red

tee docker-compose.yml <<EOF
################################################################################
# Node-RED Stack or Compose
################################################################################
# docker stack deploy node-red --compose-file docker-compose-node-red.yml
# docker-compose -f docker-compose-node-red.yml -p myNoderedProject up
################################################################################
version: "3.7"

services:
  node-red:
    image: nodered/node-red:latest
    environment:
      - TZ=Europe/Amsterdam
    ports:
      - "1880:1880"
    networks:
      - node-red-net
    volumes:
      - node-red-data:/data

volumes:
  node-red-data:

networks:
  node-red-net:
EOF

sudo docker-compose up -d




