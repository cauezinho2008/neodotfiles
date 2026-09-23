#!/usr/bin/env bash
set -euo pipefail
clear
URL="https://github.com/cauezinho2008/neodotfiles.git"
DEPS="gum
chafa
git"

rm -fr $(find /tmp/caue-dotfiles-*) >/dev/null 2>&1
DIR="$(mktemp -d /tmp/caue-dotfiles-XXXXXXX)"
clear

spinner() {
    local frames=(' / ' ' - ' ' \ ' ' | ')
    local i=0
    while true; do
        printf '\r%s  %s' "$1" "${frames[i]}"
        i=$(( (i + 1) % 4 ))
        sleep 0.1
    done
}

spinner "Downloading files..." &
spin=$!
trap 'kill "$spin" 2>/dev/null' EXIT

git clone --quiet --depth 2 $URL $DIR
kill "$spin" 2>/dev/null
clear

PM=$([[ -f /bin/pacman ]])


if $PM == "1"; then
MISS="$(comm -23 <(sort <<<"$DEPS") <(sort <<<"$(pacman -Qq $DEPS)"))"; echo "enter your sudo password to install needed dependencys: $MISS"; echo "note that your passwork is read only by pacman directly, the script never sees it"; sudo pacman -Sy $MISS; bash $DIR/menu.sh;
else clear; echo "this distro isn't supported, please install in another terminal:"; echo "$DEPS"; echo "after that please press any key to continue. otherwise the scrip will fail."; read -n 1 -p "press any key to continue..." && bash $DIR/menu.sh
fi
[[ $PM == '1' ]] && sudo pacman -Rns $MISS
clear
echo "bye!"
