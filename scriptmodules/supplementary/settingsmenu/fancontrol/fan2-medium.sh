sudo cp -r -f /home/pigaming/scripts/fan2-medium/* /sys/devices/odroid_fan.14
sudo cp -r -f /home/pigaming/scripts/fan2-medium/rc.local /etc
dialog --no-cancel --no-ok --pause 'Fan is now set to the HIGHER COOLING RATE than the factory Odroid settings.\n\nNOTE: PERFORM AT YOUR OWN RISK. NO IMPLIED WARRANTIES.' 22 76 10