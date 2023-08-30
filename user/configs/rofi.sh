#!/usr/bin/env bash

get_firefox_profile() {
    profiles=`cat "${HOME}/.mozilla/firefox/profiles.ini" | grep -P 'Name=' | sed 's/Name=//g'`
    profile=`echo -e "${profiles}" | rofi -dmenu -p "Select a profile:"`
    [[ ! -z "${profile}" ]] && echo "${profile}"
}

get_qutebrowser_profile() {
    profiles=`ls ${HOME}/.qutebrowser/`
    profile=`echo -e "${profiles}" | rofi -dmenu -p "Select a profile:"`
    [[ ! -z "${profile}" ]] && echo "${HOME}/.qutebrowser/${profile}" 
}

get_pass_account() {
    pushd "${HOME}/.password-store" > /dev/null
    account=`find . -type f -not -path '*/\.*' | sed 's/\.gpg//g' | rofi -dmenu -p "Select account:"`
    popd > /dev/null
    echo "${account}"
}

get_pass() {
    account=`get_pass_account`
    alacritty -e bash -c "pass -c \"${account}\"; read"
}

get_emoji() {
    xdotool type `rofimoji`
}

get_pass_menu() {
    local options="👤 user\n🔑 password"
    option=`echo -e "${options}" | rofi -dmenu -p "Select one:"`
    case $option in
        "👤 user")
            val=`get_pass_account | awk -F '/' '{print $(NF)}'`
            xdotool type "${val}"
            ;;
        "🔑 password")
            get_pass
            ;;
        *)
            ;;
    esac
}

custom_rofi () {
    local options="🌐 qtbrowser\n🦊 firefox\n🪟 window\n🔑 password\n😀 emoji\n🖥 ssh\n⬆️ launcher"
    option=`echo -e "${options}" | rofi -dmenu -p "Please select one:"`
    case $option in
        "🪟 window")
            rofi -show window
            ;;
        "⬆️ launcher")
            rofi -show run
            ;;
        "🌐 qtbrowser")
            profile=`get_qutebrowser_profile`
            [[ ! -z "${profile}" ]] && qutebrowser --basedir "${profile}"
            ;;
        "🦊 firefox")
            profile=`get_firefox_profile`
            [[ ! -z "${profile}" ]] && firefox -p "${profile}"
            ;;
        "🔑 password")
            get_pass_menu
            ;;
        "😀 emoji")
            get_emoji
            ;;
        "🖥 ssh")
            rofi -show ssh -terminal alacritty
            ;;
        *)
            ;;
    esac
}

$*
exit 0
