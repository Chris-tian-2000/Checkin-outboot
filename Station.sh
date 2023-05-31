#!bin/bash
echo "Welcome to your new shipping station!"


echo "Change from fullscreen to  windowed mode before we get going. ."
sleep 6

#Wifi Connection

# Prompt for SSID
read -p "Enter the SSID: " SSID

# Prompt for passphrase
read -s -p "Enter the passphrase: " PASSPHRASE
echo

# Generate the network configuration entry
config_entry="network={
   ssid=\"$SSID\"
   scan_ssid=1
   psk=\"$PASSPHRASE\"
}"

# Write the configuration entry to a temporary file
tmp_file=$(mktemp)
echo -e "$config_entry" > "$tmp_file"

# Append the configuration entry to wpa_supplicant.conf
sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf < "$tmp_file" > /dev/null
rm "$tmp_file"

echo "Wi-Fi credentials updated successfully."


echo "Updating"
sudo apt update 
sudo apt full-upgrade
sudo apt-get install network-manager -y
sudo apt-get install xdotool -y

#Install and disable the firewall.
sudo apt install ufw -y
sudo ufw disable

#Adjusting the size of the screen
echo "Setting up your station."

sleep 2

xdotool mousemove 140 120

xdotool click 3
sleep 1

xdotool mousemove 145 325
sleep 1

xdotool click 1
sleep 4

xdotool mousemove 460 170

xdotool click 1

xdotool mousemove 460 215

xdotool click 1
sleep 3

xdotool mousemove 610 140

xdotool click 1


sudo apt install chromium-browser -y
echo "Chromium is now installed!"
sleep 2

echo "Downloading Teamviewer now.."
sleep 2
wget -O ~/home/picanova/Downloads/teamviewer-host_armhf.deb  https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
#Download and set tcgroup  background
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
sleep 1
systemctl reboot -i 
