#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="settingsmenu"
rp_module_desc="The-RA configuration menu for EmulationStation"
rp_module_section="core"

function _update_hook_settingsmenu() {
    # to show as installed when upgrading to retropie-setup 4.x
    if ! rp_isInstalled "$md_idx" && [[ -f "$home/.emulationstation/gamelists/retropie/gamelist.xml" ]]; then
        mkdir -p "$md_inst"
        # to stop older scripts removing when launching from retropie menu in ES due to not using exec or exiting after running retropie-setup from this module
        touch "$md_inst/.retropie"
    fi
}

function depends_settingsmenu() {
    getDepends mc
	
}

function install_bin_settingsmenu() {
    if [[ ! -f /home/pigaming/scripts/update007 ]]; then
        cp -r $HOME/fan/original $HOME/scripts/fan1-default
        cp -r $HOME/fan/cool-mode $HOME/scripts/fan2-medium
        cp -r $HOME/fan/aggressive $HOME/scripts/fan3-aggressive
        rm -rf $HOME/fan
        wget -O /usr/bin/odroid-config https://raw.githubusercontent.com/sikotik/odroid-config/master/odroid-config
        wget -O /usr/bin/init_resize.sh https://raw.githubusercontent.com/sikotik/odroid-config/master/init_resize.sh
        chmod a+X /usr/bin/init_resize.sh && chmod a+x /usr/bin/odroid-config
        touch /home/pigaming/scripts/update007
    fi
    return
}

function configure_settingsmenu()
{
    [[ "$md_mode" == "remove" ]] && return

    local rpdir="$home/RetroPie/settingsmenu"
    mkdir -p "$rpdir"
    cp -r "$md_data/." "$rpdir/"
    chown -R $user:$user "$rpdir"

    isPlatform "mali" && rm -f "$rpdir/dispmanx.rp"

    # add the gameslist / icons
    local files=(
        'bluetooth'
        'caseconfig'
        'casetheme'
        'configedit'
        'esthemes'
        'hurstythemes'
        'filemanager'
        'odroidconfig'
        'retroarch'
        'rpsetup'
        'runcommand'
        'showip'
        'splashscreen'
    )

    local names=(
        'Bluetooth'
        'Case Config for OGST'
        'Case Themes for OGST'
        'Configuration Editor'
        'ES Themes'
        'HurstyS ES Themes'
        'File Manager'
        'Odroid-Config'
        'Retroarch'
        'TheRA-Setup'
        'Run Command Configuration'
        'Show IP'
        'Splash Screens'
    )

    local descs=(
        'Register and connect to bluetooth devices. Unregister and remove devices, and display registered and connected devices.'
        'Case image selector for OGST - choose the type of image displayed upon game launch such as console system, boxart, cartart, snap, wheel, screenshot, or marquee.'
        'Case theme selector for OGST - choose different theme packs when Console System is selected in Case Config.'
        'Change common RetroArch options, and manually edit RetroArch configs, global configs, and non-RetroArch configs.'
        'Install, uninstall, or update EmulationStation themes.'
        'Install, uninstall, or update HurstyS ES themes.'
        'Basic ascii file manager for linux allowing you to browse, copy, delete, and move files.'
        'OS and Hardware configurations such as: User Password, Boot Options, Internationalization, SSH, etc. CAUTION: This menu is EXPERIMENTAL. Use at your own risk and be sure to backup your image!'
        'Launches the RetroArch GUI so you can change RetroArch options. Note: Changes will not be saved unless you have enabled the "Save Configuration On Exit" option.'
        'Install TheRA from binary or source, install experimental packages, additional drivers, edit samba shares, custom scraper, as well as other related configurations.'
        'Change what appears on the runcommand screen. Enable or disable the menu, enable or disable box art, and change CPU configuration.'
        'Displays your current IP address, as well as other information provided by the command, "ip addr show."'
        'Enable or disable the splashscreen on The-RA boot. Choose a splashscreen, download new splashscreens, and return splashscreen to default.'
    )

    setESSystem "RetroPie" "retropie" "$rpdir" ".rp .sh" "sudo $scriptdir/retropie_packages.sh settingsmenu launch %ROM% </dev/tty >/dev/tty" "" "retropie"

    local file
    local name
    local desc
    local image
    local i
    for i in "${!files[@]}"; do
        case "${files[i]}" in
            raspiconfig|splashscreen)
                ! isPlatform "mali" && continue
                ;;
            wifi)
                [[ "$__os_id" != "Ubuntu" ]] && continue
        esac

        file="${files[i]}"
        name="${names[i]}"
        desc="${descs[i]}"
        image="$home/RetroPie/settingsmenu/icons/${files[i]}.png"

        touch "$rpdir/$file.rp"

        local function
        for function in $(compgen -A function _add_rom_); do
            "$function" "retropie" "RetroPie" "$file.rp" "$name" "$desc" "$image"
        done
    done
    
    #update gamelist
    cp -rf "$rpdir/gamelist.xml" "$home/.emulationstation/gamelists/retropie/gamelist.xml"
}

function remove_settingsmenu() {
    rm -rf "$home/RetroPie/settingsmenu"
    rm -rf "$home/.emulationstation/gamelists/retropie"
    delSystem retropie
}

function launch_settingsmenu() {
    clear
    local command="$1"
    local basename="${command##*/}"
    local no_ext="${basename%.rp}"
    joy2keyStart
    case "$basename" in
        retroarch.rp)
            joy2keyStop
            cp "$configdir/all/retroarch.cfg" "$configdir/all/retroarch.cfg.bak"
            chown $user:$user "$configdir/all/retroarch.cfg.bak"
            su $user -c "\"$emudir/retroarch/bin/retroarch\" --menu --config \"$configdir/all/retroarch.cfg\""
            iniConfig " = " '"' "$configdir/all/retroarch.cfg"
            iniSet "config_save_on_exit" "false"
            ;;
        rpsetup.rp)
            rp_callModule setup gui
            ;;
        odroidconfig.rp)
            odroid-config
            ;;
        filemanager.rp)
            mc
            ;;
        showip.rp)
            local ip="$(ip route get 8.8.8.8 2>/dev/null | awk '{print $NF; exit}')"
            printMsgs "dialog" "Your IP is: $ip\n\nOutput of 'ip addr show':\n\n$(ip addr show)"
            ;;
        *.rp)
            rp_callModule $no_ext depends
            if fnExists gui_$no_ext; then
                rp_callModule $no_ext gui
            else
                rp_callModule $no_ext configure
            fi
            ;;
        *.sh)
            cd "$home/RetroPie/settingsmenu"
            sudo -u "$user" bash "$command"
            ;;
    esac
    joy2keyStop
    clear
}
