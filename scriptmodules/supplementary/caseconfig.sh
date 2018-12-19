#!/usr/bin/env bash

# This file is part of TheRA Project
#
# The TheRA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="caseconfig"
rp_module_desc="OGST Case Image Selector"
rp_module_section="config"

function gui_caseconfig() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "OGST Configuration" 22 86 16)
    local options=(
        1 "System Case Only"
        2 "Skyscraper: roms/system/media/marquees/game.png"
        3 "Skyscraper: roms/system/media/screenshots/game.png"
        4 "Standard:   roms/system/marquees/game.png"
        5 "Standard:   roms/system/screenshots/game.png"
        6 "ES Scaper:  .emulationstation/downloaded_images/system/game-image.png"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst001
                printMsgs "dialog" "Option 1 Activated"
                ;;
            2)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst002
                printMsgs "dialog" "Option 2 Activated"
                ;;
            3)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst003
                printMsgs "dialog" "Option 3 Activated"
                ;;
            4)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst004
                printMsgs "dialog" "Option 4 Activated"
                ;;
            5)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst005
                printMsgs "dialog" "Option 5 Activated"
                ;;
            6)
                rm -rf $HOME/scripts/ogst*
                touch $HOME/scripts/ogst006
                printMsgs "dialog" "Option 6 Activated"
                ;;
        esac
    fi
}
