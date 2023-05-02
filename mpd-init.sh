#/bin/sh

echo • ===================================================================================== •
# Disable previous presets
mpc stop && mpc clear > /dev/null
systemctl disable mpd-watchdog > /dev/null

echo • ===================================================================================== •
# installing packages
sudo apt-get --yes --force-yes install -f mpd mpc

echo • ===================================================================================== •

# /// Setting local mixer presets!!! 
sudo amixer set 'Line In' mute 0% > /dev/null
sudo amixer set 'Line Out' unmute 80% > /dev/null
sudo amixer set 'Line Out Source' 'Mono Differential' > /dev/null
sudo amixer set 'Mic1' mute 0% > /dev/null
sudo amixer set 'Mic1 Boost' mute 0% > /dev/null
sudo amixer set 'Mic2' mute 0% > /dev/null
sudo amixer set 'Mic2 Boost' mute 0% > /dev/null
#sudo amixer setl 'Mixer'  > /dev/null
#sudo amixer set 'Mixer Reversed'  > /dev/null
sudo amixer set 'ADC Gain' mute 0% > /dev/null
sudo amixer set 'DAC' unmute 80% > /dev/null
sudo amixer set 'DAC Reversed' mute 0% > /dev/null
# Setting local mixer presets!!! ////

sudo alsactl store 0

echo • ===================================================================================== •

mpc repeat on && mpc random on
mpc clear
# mpc add https://listen2.myradio24.com/8226
# mpc add http://195.242.219.208:8200/enigma
# mpc add https://montecarlo.hostingradio.ru/montecarlo96.aacp
mpc add http://10.79.0.19:8000/
mpc play

echo • ===================================================================================== •
mkdir /srv/http && mkdir /srv/http/command
cd /srv/http/command

echo • ===================================================================================== •
rm /srv/http/command/mpd-watchdog > /dev/null
wget https://raw.githubusercontent.com/DevShip/MarketAudioPlayer/main/mpd-watchdog
chmod +x mpd-watchdog

echo • ===================================================================================== •
cd /usr/lib/systemd/system
rm /usr/lib/systemd/system/mpd-watchdog.service > /dev/null
wget https://raw.githubusercontent.com/DevShip/MarketAudioPlayer/main/mpd-watchdog.service

echo • ===================================================================================== •
systemctl enable mpd-watchdog
systemctl start mpd-watchdog
systemctl status mpd-watchdog

echo • ===================================================================================== •
mpc current
