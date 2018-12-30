#!/usr/bin/env bash

# This file is part of TheRA Project
#
# The TheRA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="bgmtoggle"
rp_module_desc="Enable or disable the background music feature."
rp_module_section="config"

function gui_bgmtoggle() {
    source /home/pigaming/RetroPie/settingsmenu/bgm-toggle.sh
}
