#!/bin/bash

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
