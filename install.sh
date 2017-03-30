#https://github.com/Smarina/Raspflix

echo "Automount /dev/sda1 to /mnt/moviedrive"
#automount sda1
echo '/dev/sda1 /mnt/moviedrive ntfs defaults 0 0' >> /etc/fstab
chmod 777 -R /mnt/moviedrive



#Plex
# https://www.element14.com/community/community/raspberry-pi/raspberrypi_projects/blog/2016/03/11/a-more-powerful-plex-media-server-using-raspberry-pi-3
apt-get install apt-transport-https -y --force-yes
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list
apt-get update

echo "Installing Plex server"
apt-get install -t jessie plexmediaserver -y
echo "Plex server installed"



# Deluge
# http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient
echo "Installing Deluge"
apt-get install deluged deluge-console deluge-web
#Create auth config
deluged
pkill deluged
cp ~/.config/deluge/auth ~/.config/deluge/auth.old
echo "pi:raspberry:10" >> ~/.config/deluge/auth

echo "Creating directory structure for deluge at /mnt/moviedrive/deluge"
mkdir -p /mnt/moviedrive/deluge/watch
mkdir /mnt/moviedrive/deluge/downloading
mkdir /mnt/moviedrive/deluge/torrent-backup
mkdir /mnt/moviedrive/deluge/completed

echo "Downloading \"torrents downloader\""
cd /mnt/moviedrive/deluge && wget "https://raw.githubusercontent.com/Smarina/Raspflix/master/torrentDownloader.sh"

echo "Booting up Deluge web ui"
deluge-web --fork

echo "Deluge ready"



#node-red
echo "Installing NPM and node-red"
apt-get install npm
npm install -g npm@2.x
npm install -g --unsafe-perm node-red
echo "Adding dashboard package to node-red"
cd ~/.node-red && npm i node-red-dashboard
echo "Downloading node-red Raspflix flow"
cd ~/.node-red/lib/flows && wget "https://raw.githubusercontent.com/Smarina/Raspflix/master/raspflix-node-red-setup.json"



echo "Fixing the IP address"
read -p "Type the desired IP address for the server:" desiredIp
echo "ip=$desiredIp" >> /boot/cmdline.txt