#!/usr/bin/env bash
set -euo pipefail
#clear
URL="https://github.com/cauezinho2008/neodotfiles.git"
deps=(fzf, git, rm, find, mktemp)
source /etc/os-release

rm -fr $(find /tmp/caue-dotfiles-*) >/dev/null 2>&1
DIR="$(mktemp -d /tmp/caue-dotfiles-XXXXXXX)"
clear
spinner() {
    local frames=('|' '/' '-' '\')   # the four animation frames
    local i=0
    while true; do
        printf '\r%s  %s' "$1" "${frames[i]}"   # redraw the same line: \r = return carriage
        i=$(( (i + 1) % 4 ))                    # next frame, looping forever
        sleep 0.1
    done
}

# THE COMBO: launch the spinner in the BACKGROUND ...
spinner "Downloading files..." &
spin_pid=$!                 # ... remember its PID ...
trap 'kill "$spin_pid" 2>/dev/null' EXIT   # ... and make sure it dies when we exit

#git clone --quiet --depth 2 $URL $DIR
sleep 10
kill "$spin_pid" 2>/dev/null
printf '\r%-60s\n' "done: $DIR"


case ""$ID_LIKE"" in
 arch) echo "arch detected";;
 *) echo "please select your distro's package manager"
 esac
echo "bye!"
bash $DIR/fetch.sh
