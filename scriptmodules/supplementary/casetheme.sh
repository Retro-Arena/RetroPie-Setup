#!/usr/bin/env bash

# This file is part of TheRA Project
#
# The TheRA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="casetheme"
rp_module_desc="OGST Case Theme Selector"
rp_module_section="config"

function gui_casetheme() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "OGST Case Theme Selector" 22 86 16)
    local options=(
        1 "Retro-Arena (default)"
        2 "Greatest-Hits"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                cd "$HOME/.emulationstation/ogst_themes"
                rm -rf ogst-retroarena
                sudo git clone https://github.com/Retro-Arena/ogst-retroarena ogst-retroarena
                printMsgs "dialog" "Option 1 Installed"
                ;;
            2)
                cd "$HOME/.emulationstation/ogst_themes"
                rm -rf ogst-retroarena
                sudo git clone https://github.com/Retro-Arena/ogst-greatest-hits ogst-retroarena
                printMsgs "dialog" "Option 2 Installed"
                ;;
        esac
    fi
}
