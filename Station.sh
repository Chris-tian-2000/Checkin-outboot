#!bin/bash

echo "Welcome to your new shipping station!"
sleep 2

echo "Setting up your station"
sleep 2

xdotool mousemove 460 170

xdotool click 3
sleep 1

xdotool mousemove 465 380
sleep 1

xdotool click 1
sleep 4

xdotool mousemove 460 170

xdotool click 1

xdotool mousemove 460 215

xdotool click 1

echo "Updating"
sudo apt update 
sudo apt full-upgrade
sudo apt-get install network-manager
sudo apt-get install xdotool

#Install and disable the firewall.
sudo apt install ufw
sudo ufw disable

sudo apt install chromium-browser -y
echo "Chromium is now installed!"
sleep 2

echo "Downloading Teamviewer now.."
sleep 2
wget  https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb

#Download and set background
wget -O image.jpg "https://images.teamtailor-cdn.com/images/s3/teamtailor-production/landscape_16_9-v3/image_uploads/db21535e-df8c-41d6-ba34-976a3b860bfb/ori>

pcmanfm --set-wallpaper="/home/picanova/image.jpg"

echo "Is this a check-in/out station? (y/n)"
read response

while true; do
    if [[ "$response" =~ ^[Yy]$ ]]; then
        source checkin-out.sh
        break
    elif [[ "$response" =~ ^[Nn]$ ]]; then
        break
    else
echo "Invalid input. Please enter y or n."
        read response
    fi
done

#The defualt name is WS-RPI-(LOCATION-NUMBER)
echo "Hostname:"
read hostname
sudo sed -i 's/raspberrypi/'$hostname'/g' /etc/hosts
sudo sed -i 's/raspberrypi/'$hostname'/g' /etc/hostname

echo "This script only runs once, it will be deleted now."
sleep 1
#sudo rm station.sh

echo "Rebooting.."
systemctl reboot -i 
