#!bin\bash

echo "Welcome to your new Checkin-out Station"
sleep 1

sudo mv /home/picanova/Tempauto/checkin-startup ~/.config/autostart
 
#sudo rm checkin-out.sh

echo "Rebooting.."
reboot
