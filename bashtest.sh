#!/bin/bash

SSID="Picanova_Iot"
PASSPHRASE="J<G?rK}kv6QDJx5y"

# Generate the network configuration entry
config_entry="network={
   ssid=\"$SSID\"
   scan_ssid=1
   psk=\"$PASSPHRASE\"
}"

# Append the configuration entry to wpa_supplicant.conf
echo -e "$config_entry" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null

# Restart networking service
sudo systemctl restart networking

COUNT=0
FAILED=false
# Wait until Wi-Fi is connected
while $COUNT le 10; do
    sleep 1
    if ! iwconfig wlan0 | grep -q "ESSID:\"$SSID\"";
        $COUNT = 10;
    else if $COUNT = 9;
        $COUNT = $COUNT + 1
        $FAILED = true
    else
        $COUNT = $COUNT + 1
done

# Wi-Fi is connected, continue with the rest of the script
echo "Wi-Fi connected!"
# Add your desired commands or actions here