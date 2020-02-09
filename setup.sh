EXECUTABLE_SH=backup.sh
EXECUTABLE=backup
ENVIRONMENT_FILES=.config
PRIVATE_FILES=".env include-directories.txt watch-directories.txt"
SERVICE_UNIT=backup.service
DAEMON=backup

cp $EXECUTABLE_SH $EXECUTABLE
sudo mv $EXECUTABLE /usr/bin

sudo mkdir /etc/backup
sudo cp $ENVIRONMENT_FILES /etc/backup
sudo cp $PRIVATE_FILES /etc/backup

sudo cp $SERVICE_UNIT /etc/systemd/system

systemctl daemon-reload
systemctl enable $DAEMON
