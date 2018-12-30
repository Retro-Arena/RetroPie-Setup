sudo cp -r -f /home/pigaming/scripts/fan3-aggressive/* /sys/devices/odroid_fan.14
sudo cp -r -f /home/pigaming/scripts/fan3-aggressive/rc.local /etc
dialog --no-cancel --no-ok --pause 'Fan is now set to the most AGGRESSIVE COOLING RATE than the factory Odroid settings. The fan will become noticeably loud.\n\nNOTE: PERFORM AT YOUR OWN RISK. NO IMPLIED WARRANTIES.' 22 76 10
