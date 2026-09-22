source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


oh-my-posh init fish --config ~/.config/fish/oh_my_posh/config.omp.json | source

# fzf theme, layout and keybinds (matches dotfiles repo scripts)
set -gx FZF_DEFAULT_OPTS "--layout=reverse --border=rounded --height=75% --pointer='▶ ' --marker='* ' --bind 'tab:toggle' --bind 'ctrl-a:select-all' --bind 'ctrl-d:deselect-all' --bind 'esc:abort' --color=bg:-1,bg+:#112240,fg:#d0d0d0,fg+:#ffffff --color=border:#4A6FA5,header:#6A9EFF,info:#6A9EFF --color=pointer:#6A9EFF,marker:#6A9EFF,prompt:#6A9EFF --color=spinner:#6A9EFF,hl:#6A9EFF,hl+:#8BB8FF"

# history: keep 100000 commands
set -g fish_history_size 100000
