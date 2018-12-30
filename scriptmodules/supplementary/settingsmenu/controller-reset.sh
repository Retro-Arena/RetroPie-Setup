#!/bin/bash
dialog --no-cancel --no-ok --pause 'This will reset all of your controllers, then perform a REBOOT.\n\nThis will wipe out all controller configurations and reset everything to factory default.\n\nYou will need to reconfigure all of your controllers.' 22 76 10
if [ ! -f /usr/bin/curl ]; then
    sudo apt-get install -y curl
fi
rm /opt/retropie/configs/all/retroarch-joypads/*
rm $HOME/.emulationstation/es_input.cfg
cd $HOME/.emulationstation/; curl -o es_input.cfg https://raw.githubusercontent.com/Shakz76/Eazy-Hax-RetroPie-Toolkit/master/cfg/es_input.cfg.bkup
sudo reboot
