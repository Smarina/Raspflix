#https://github.com/Smarina/Raspflix

#automount sda1
echo '/dev/sda1 /media/harddrive ntfs defaults 0 0' >> /etc/fstab
chmod 777 -R /media/harddrive


# https://www.element14.com/community/community/raspberry-pi/raspberrypi_projects/blog/2016/03/11/a-more-powerful-plex-media-server-using-raspberry-pi-3
apt-get install apt-transport-https -y --force-yes
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list
apt-get update


#Plex
echo "Installing Plex server"
apt-get install -t jessie plexmediaserver -y
echo "Plex server installed"


# rtorrent
echo "Installing rtorrent"
aptitude install rtorrent
echo "Creating directory structure for rtorrent"
mkdir -p /media/harddrive/tracker/leeching
mkdir /media/harddrive/tracker/rtactive
mkdir /media/harddrive/tracker/sorted
mkdir /media/harddrive/tracker/torrents
mkdir /media/harddrive/tracker/unsorted
echo "Downloading rtorrent config file"
cd ~ && wget "https://raw.githubusercontent.com/Smarina/Raspflix/master/.rctorrent.rc"
cd /media/harddrive/tracker && wget "https://raw.githubusercontent.com/Smarina/Raspflix/master/torrentDownloader.sh"
echo "rtorrent ready"


#node-red
#echo "Installing NPM and node-red"
#apt-get install npm
#npm install -g npm@2.x
#npm install -g --unsafe-perm node-red
echo "Adding dashboard package to node-red"
cd ~/.node-red && npm i node-red-dashboard


echo "Fixing the IP address"
read -p "Type the desired IP address for the server:" desiredIp
echo "ip=$desiredIp" >> /boot/cmdline.txt