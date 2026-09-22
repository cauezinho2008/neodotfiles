#!/usr/bin/env bash
set -euo pipefail
clear
URL="https://github.com/cauezinho2008/neodotfiles.git"
deps="fzf git rm find mktemp"
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
read -n 1 -s -p "install extra tools? (y/n): " answer
echo $answer

echo "bye!"

for frame in '/' '-' '\' '|' ; do
    printf '\r%s %s' "$frame"
done
