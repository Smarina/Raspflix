cd /mnt/moviedrive/deluge
if [ ! -f "./torrent-backup/$2.torrent" ]; then
    curl -o "./watch/$2.torrent" $1
else
	echo "$2 has been already downloaded"
fi