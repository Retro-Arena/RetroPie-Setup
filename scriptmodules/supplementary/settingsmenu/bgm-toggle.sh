#!/usr/bin/env bash

stop_bgm(){
    pkill -STOP mpg123
    sudo rm /home/pigaming/scripts/bgm/start.sc
    clear
    dialog --no-cancel --no-ok --pause 'Background Music Disabled.' 22 76 10
}

start_bgm(){
    pkill -CONT mpg123
    touch /home/pigaming/scripts/bgm/start.sc
    dialog --no-cancel --no-ok --pause 'Background Music Enabled.' 22 76 10
    sleep 3
}

if [ -a /home/pigaming/scripts/bgm/start.sc ]; then
    stop_bgm
else
    start_bgm
fi

exit
