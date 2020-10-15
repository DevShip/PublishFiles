#/bin/sh

sudo apt-get install mpd mpc
sudo alsamixer
sudo alsamixer store 0

mpc repeat on
mpc random on

mpc clear
mpc add https://listen2.myradio24.com/8226
mpc add http://195.242.219.208:8200/enigma

mpc play

mkdir /srv/http
mkdir /srv/http/command

cd /srv/http/command
wget https://raw.githubusercontent.com/DevShip/PublishFiles/main/mpd-watchdog
chmod +x mpd-watchdog
cd /usr/lib/systemd/system
wget https://raw.githubusercontent.com/DevShip/PublishFiles/main/mpd-watchdog.service
systemctl enable mpd-watchdog

systemctl start mpd-watchdog
systemctl status mpd-watchdog

mpc current
