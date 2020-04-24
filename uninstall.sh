#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Remove /usr/bin/undercover ..."
rm /usr/bin/undercover
echo "Remove /usr/share/undercover ..."
rm -rf /usr/share/undercover
echo "Remove /usr/share/theme/Windows-10 ..."
rm -rf /usr/share/themes/Windows-10
echo "Remove /usr/share/icons/Windows-10-Icons ..."
rm -rf /usr/share/icons/Windows-10-Icons

echo "Removing windows banner from ~/.bashrc"

sed -i -e 's/print_win_banner() {//g' ~/.bashrc
sed -i -e 's/echo \"M1cr0s0ft W1nd0ws \[Version 10.0.17763.55\]\" //g' ~/.bashrc
sed -i -e 's/echo \"(c) 2018 M1cr0s0ft C0rp0r4ti0n. All rights reserved.\" //g' ~/.bashrc
sed -i -e 's/echo \"\" //g' ~/.bashrc
sed -i -e 's/ \}//g' ~/.bashrc
sed -i -e 's/print_win_banner;//g' ~/.bashrc
sed -i -e 's/#print_win_banner;//g' ~/.bashrc

echo "Ready"
