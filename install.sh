#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cp kali-undercover.sh /usr/bin/kali-undercover
chmod 755 /usr/bin/kali-undercover
cp -r kali-undercover /usr/share/kali-undercover
chmod +x /usr/share/kali-undercover/scripts/xfce4-desktop-profiles.py
cp -r Windows-10 /usr/share/themes/Windows-10
chmod 755 -R /usr/share/themes/Windows-10
cp -r Windows-10-Icons /usr/share/icons/Windows-10-Icons
chmod 755 -R /usr/share/icons/Windows-10-Icons
echo "Ready"