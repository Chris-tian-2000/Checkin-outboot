#!bin\bash

echo "Welcome to your new Checkin-out Station"
sleep 1

#The default layout is CHECK-IN-OUT-(LOCATION)
echo "Hostname:"
read hostname
sudo sed -i 's/raspberrypi/'$hostname'/g' /etc/hosts
sudo sed -i 's/raspberrypi/'$hostname'/g' /etc/hostname
 
#sudo rm checkin-out.sh

echo "Rebooting.."
reboot
