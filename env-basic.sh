##### PROGRAMS WILL BE INSTALLED #####################################################
# * GOOGLE-CHROME
# * BRAVE
# * TWEAKS
# * SPOTIFY


SNAP_PROGRAMS=$( snap list )
DPKG_PROGRAMS=$( dpkg --get-selections )
sudo apt update

echo "================================================================================"
echo "[$( date "+%Y/%m/%d %H:%M:%S" )] INSTALLING google-chrome"
echo            "--------------------------------------"
PROGRAM=$( echo "$DPKG_PROGRAMS" | grep google-chrome )
if [ "$PROGRAM" = "" ] ; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
else
	echo "'google-chrome' already installed. Ignored"
fi

echo "================================================================================"
echo "[$( date "+%Y/%m/%d %H:%M:%S" )] INSTALLING BRAVE"
echo            "--------------------------------------"
PROGRAM=$( echo "$SNAP_PROGRAMS" | grep brave )
if [ "$PROGRAM" = "" ] ; then
  sudo snap install brave
else
	echo "'Brave' already installed. Ignored"
fi

echo "================================================================================"
echo "[$( date "+%Y/%m/%d %H:%M:%S" )] INSTALLING gnome-tweak-tool"
echo            "--------------------------------------"
PROGRAM=$( echo "$DPKG_PROGRAMS" | grep gnome-tweak-tool )
if [ "$PROGRAM" = "" ] ; then
#	sudo add-apt-repository universe
	sudo apt install -y gnome-tweak-tool
	# User themes
	# Clipboard
	# dash to panel
  # system-monitor
  # Bring Out Submenu Of Power Off
  # Better OSD
  # Workspace matrix
  sudo apt-get install chrome-gnome-shell
	sudo apt install gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0
else
	echo "'gnome-tweak-tool' already installed. Ignored"
fi

echo "================================================================================"
echo "[$( date "+%Y/%m/%d %H:%M:%S" )] INSTALLING SPOTIFY"
echo            "--------------------------------------"

PROGRAM=$( echo "$SNAP_PROGRAMS" | grep spotify )
if [ "$PROGRAM" = "" ] ; then
	snap install spotify
else
	echo "'Spotify' already installed. Ignored"
fi

