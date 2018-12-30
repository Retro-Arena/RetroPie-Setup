#!/usr/bin/env bash

# This file is part of TheRA Project
#
# The TheRA Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#

rp_module_id="odroid-config"
rp_module_desc="Expand filesystem, configure network, boot, localisation, SSH"
rp_module_section="config"

function gui_odroid-config() {
    source /usr/bin/odroid-config
}
