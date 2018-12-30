sudo cp -r -f /home/pigaming/scripts/fan1-default/* /sys/devices/odroid_fan.14
sudo cp -r -f /home/pigaming/scripts/fan1-default/rc.local /etc
dialog --no-cancel --no-ok --pause 'Fan is now restored to the factory Odroid settings.' 22 76 10