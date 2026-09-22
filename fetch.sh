#!/usr/bin/env bash
set -euo pipefail
clear
URL="https://github.com/cauezinho2008/neodotfiles.git"
deps="gum chafa git rm find mktemp"
source /etc/os-release

spinner() {
    local frames=(' / ' ' - ' ' \ ' ' | ')
    local i=0
    while true; do
        printf '\r%s  %s' "$1" "${frames[i]}"
        i=$(( (i + 1) % 4 ))
        sleep 0.1
    done
}
rm -fr $(find /tmp/caue-dotfiles-*) >/dev/null 2>&1
DIR="$(mktemp -d /tmp/caue-dotfiles-XXXXXXX)"
clear
spinner "Downloading files..." &
spin=$!
trap 'kill "$spin" 2>/dev/null' EXIT

git clone --quiet --depth 2 $URL $DIR
kill "$spin" 2>/dev/null
clear
PM="$(if command -v apt > /dev/null 2>&1; then
    echo "apt package manager"
elif command -v dnf > /dev/null 2>&1; then
    echo "dnf package manager"
elif command -v yum > /dev/null 2>&1; then
    echo "yum package manager"
elif command -v zypper > /dev/null 2>&1; then
    echo "zypper package manager"
elif command -v pacman > /dev/null 2>&1; then
    echo "pacman package manager"
else
   gum choose "pacman""paru" "dnf" "apt" --header "please choose your distro's package manager:"
fi)"

MISS="$(comm -23 $deps $($PM) > file1_only)"

echo "bye!"
