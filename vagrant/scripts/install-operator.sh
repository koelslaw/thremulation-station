OPERATOR_URL="https://download.prelude.org/latest?platform=linux&variant=appImage"
VAGRANT_HOME="/home/vagrant"


# Set XCFE as default for CentOS splash
touch /etc/sysconfig/desktop
echo "DESKTOP=XFCE" > /etc/sysconfig/desktop

# Set XFCE as default for XRDP connections
touch $VAGRANT_HOME/.Xclients
echo "startxfce4" > $VAGRANT_HOME/.Xclients
chmod +x $VAGRANT_HOME/.Xclients
systemctl restart xrdp


# Stage and download and install Operator
cd "$(mktemp -d)"
curl --silent -LJ $OPERATOR_URL -o operator.appImage
sleep 10
cp operator.appImage $VAGRANT_HOME
cd $VAGRANT_HOME
chmod +x operator.appImage
./operator.appImage --appimage-extract
sleep 20

chown vagrant: -R $VAGRANT_HOME/squashfs-root

# Set perms for Operator related binary
chown root: $VAGRANT_HOME/squashfs-root/chrome-sandbox && chmod 4755 $VAGRANT_HOME/squashfs-root/chrome-sandbox
