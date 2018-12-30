#!/usr/bin/env bash

# This file is part of TheRA Project
#
# The TheRA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="systeminfo"
rp_module_desc="View your CPU temps, IP connectivity, and storage to include external storage addons."
rp_module_section="config"

function gui_systeminfo() {
    source /home/pigaming/RetroPie/settingsmenu/systeminfo.sh
}
