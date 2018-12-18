#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="kodi"
rp_module_desc="Kodi - Open source home theatre software"
rp_module_licence="GPL2 https://raw.githubusercontent.com/xbmc/xbmc/master/LICENSE.GPL"
rp_module_section="opt"
rp_module_flags="!mali !osmc !xbian !kms"

function _update_hook_kodi() {
    # to show as installed in retropie-setup 4.x
    hasPackage kodi && mkdir -p "$md_inst"
}

function depends_kodi() {
    if isPlatform "rpi"; then
        if [[ "$md_mode" == "install" ]]; then
            # remove old repository
            rm -f /etc/apt/sources.list.d/mene.list
            echo "deb http://pipplware.pplware.pt/pipplware/dists/$__os_codename/main/binary/ ./" >/etc/apt/sources.list.d/pipplware.list
            wget -q -O- http://pipplware.pplware.pt/pipplware/key.asc | apt-key add - &>/dev/null
        else
            rm -f /etc/apt/sources.list.d/pipplware.list
            apt-key del 4096R/BAA567BB >/dev/null
        fi
    elif isPlatform "x86" && [[ "$md_mode" == "install" ]]; then
        apt-add-repository -y ppa:team-xbmc/ppa
    fi

    getDepends policykit-1

    addUdevInputRules
}

function install_bin_kodi() {
    local accepted=0
    whiptail --yes-button "Accept" --no-button "Decline" --defaultno --yesno "If you choose to install this application you are accepting that if you utilize Add-Ons you are fully responsible for any legal outcome or action taken for said use of the Add-Ons you have installed and configured. The Retro Arena takes no responsibility for the installation or use of Kodi nor any of its Add-Ons features. By clicking yes you are consenting to full responsibilty. By clicking yes you also accept that The Retro Arena nor its community are required to provide any support for the installation of this software." 15 60 2>&1 >/dev/tty && accepted=1
    if [[ "$accepted" -ne 1 ]]; then
       md_ret_errors+=("$md_desc Agreement not accepted, install aborted.")
       return
    fi
    # force aptInstall to get a fresh list before installing
    __apt_update=0
    aptInstall kodi kodi-peripheral-joystick kodi-inputstream-adaptive kodi-inputstream-rtmp
}

function remove_kodi() {
    aptRemove kodi
    rp_callModule kodi depends remove
}

function configure_kodi() {
    # remove old directLaunch entry
    delSystem "$md_id" "kodi"

    moveConfigDir "$home/.kodi" "$md_conf_root/kodi"

    addPort "$md_id" "kodi" "Kodi" "kodi"
}
