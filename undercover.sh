#!/bin/sh

if [ $(pgrep -u $(whoami) xfconfd\|xfce4-panel | wc -l) -lt 2 ]
then
	echo "ERROR: Undercover Mode only works on Xfce desktop" >&2
	echo "Try running this without root"
	notify-send -i dialog-warning 'Undercover Mode only works on Xfce desktop'
	exit 1
fi

DIR=~/.local/share/undercover/
SHARE_DIR=/usr/share/undercover/
CONF_FILES=$SHARE_DIR/config/
XFCE4_DESKTOP_PROFILES=$SHARE_DIR/scripts/xfce4-desktop-profiles.py
UNDERCOVER_PROFILE=$SHARE_DIR/undercover-profile.tar.bz
USER_PROFILE=$DIR/user-profile.tar.bz

mkdir -p $DIR

# Hide existing notifications
killall xfce4-notifyd 2> /dev/null


if [ -f $DIR/lock ]
then
	mv $DIR/user-panel-profile.tar.bz $USER_PROFILE
	. $DIR/lock
	xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "$GTK_THEME"
	xfconf-query -c xfwm4 -p /general/theme -n -t string -s "$WM_THEME"
	xfconf-query -c xfwm4 -p /general/button_layout -n -t string -s "$WM_BUTTON_LAYOUT"
	xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "$ICON_THEME"
	xfconf-query -c xsettings -p /Gtk/CursorThemeName -n -t string -s "$CURSOR_THEME"
	xfconf-query -c xsettings -p /Gtk/FontName -n -t string -s "$FONT"
fi

enable_undercover() {
	$XFCE4_DESKTOP_PROFILES save $USER_PROFILE
	$XFCE4_DESKTOP_PROFILES load $UNDERCOVER_PROFILE
	if pgrep -u $(whoami) -x plank > /dev/null
	then
		killall plank
		touch $DIR/plank
	fi
	(cd $CONF_FILES && \
		find . -type f -exec sh -c \
			'[ -f ~/.config/"$1" ] && mv ~/.config/"$1" ~/.config/"${1}.undercover"' _ {} \;)
	cp -r $CONF_FILES/* ~/.config/
	[ -f ~/.face ] && mv ~/.face ~/.face.undercover
	printf ': undercover && export PS1='\''C:${PWD//\//\\\\\}> '\''\n' >> ~/.bashrc
	#enable call to the print_win_banner function
	sed -i -e 's/#print_win_banner;/print_win_banner;/g' ~/.bashrc

}

disable_undercover() {
	$XFCE4_DESKTOP_PROFILES load $USER_PROFILE
	[ -f $DIR/plank ] && plank > /dev/null &
	rm -r $DIR
	(cd $CONF_FILES && \
		find . -type f -exec rm ~/.config/{} \;)
	find ~/.config -name '*.undercover' -exec sh -c \
		'mv "$1" "$(echo $1 | sed 's/.undercover//')"' _ {} \;
	[ -f ~/.face.undercover ] && mv ~/.face.undercover ~/.face
	sed -i -e '/: undercover/d' ~/.bashrc
	#disable call to the print_win_banner function
	sed -i -e 's/print_win_banner;/#print_win_banner;/g' ~/.bashrc
}

if [ -f $USER_PROFILE ]
then
	disable_undercover
	sleep 1
	notify-send -i dialog-information 'Desktop settings restored'
else
	enable_undercover
fi

if [ $(cat /proc/$PPID/comm) = 'bash' ]
then
	clear
	bash
fi
