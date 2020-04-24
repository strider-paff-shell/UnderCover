#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Copy undercover.sh to /usr/bin/undercover ..."
cp undercover.sh /usr/bin/undercover
echo "Set /usr/bin/undercover to 755 ..."
chmod 755 /usr/bin/undercover
echo "Copy undercover/ to /usr/share/undercover ..."
cp -r undercover /usr/share/undercover
echo "Set /usr/bin/undercover/scripts/xfce4-desktop-profiles.py to 755 ..."
chmod 755 /usr/share/undercover/scripts/xfce4-desktop-profiles.py
echo "Copy Windows-10 to /usr/share/themes/Windows-10 ..."
cp -r Windows-10 /usr/share/themes/Windows-10
echo "Set /usr/share/themes/Windows-10 to 755 ..."
chmod 755 -R /usr/share/themes/Windows-10
echo "Copy Windows-10-Icons to /usr/share/icons/Windows-10-Icons ..."
cp -r Windows-10-Icons /usr/share/icons/Windows-10-Icons
echo "Set /usr/share/icons/Windows-10-Icons to 755 ..."
chmod 755 -R /usr/share/icons/Windows-10-Icons


echo "Adding windows banner to ~/.bashrc"
printf 'print_win_banner() {\necho "M1cr0s0ft W1nd0ws [Version 10.0.17763.55]" \necho "(c) 2018 M1cr0s0ft C0rp0r4ti0n. All rights reserved." \necho "" \n }\n' >> ~/.bashrc
printf '#print_win_banner;' >> ~/.bashrc

echo "Ready"
