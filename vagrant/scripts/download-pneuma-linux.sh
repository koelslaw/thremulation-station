#!/bin/bash

PNEUMA_URL="https://s3.amazonaws.com/operator.payloads.open/payloads/pneuma/pneuma-linux"
INSTALL_DIR="/opt/pneuma"
SCRIPTS_DIR="/vagrant"

# Stage Pneuma download

cd "$(mktemp -d)"
curl $PNEUMA_URL -o pneuma-agent
mkdir $INSTALL_DIR
cp pneuma-agent $INSTALL_DIR
chmod +x $INSTALL_DIR/pneuma-agent
cp pneuma-agent.service /etc/systemd/system

# Cleanup temporary directory
cd ..
rm -rf "$(pwd)"

systemctl enable pneuma-agent
systemctl start pneuma-agent
