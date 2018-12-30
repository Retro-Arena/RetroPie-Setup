#!/usr/bin/env bash

# This file is part of The-RA Project
#
# The The-RA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="wifi"
rp_module_desc="Connect to a wireless network via NMTUI"
rp_module_section="config"

function gui_wifi() {
    nmtui
}
