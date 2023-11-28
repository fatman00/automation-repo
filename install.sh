#/bin/bash

#install commands:

git clone https://github.com/fatman00/network-api.git

cd network-api
sed -i 's/8000:8000/8001:8000/g' docker-compose.yml

nano app/device_inventory.yaml 

DEVNET-IOSXE:
  ip: sandbox-iosxe-latest-1.cisco.com
  username: developer
  password: C1sco12345
  device_type: iosxe

sudo docker-compose up -d
