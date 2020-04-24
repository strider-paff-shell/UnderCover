#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

rm /usr/bin/kali-undercover
rm -rf /usr/share/kali-undercover
rm -rf /usr/share/themes/Windows-10
rm -rf /usr/share/icons/Windows-10-Icons
echo "Ready"