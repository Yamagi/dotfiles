# Bindings
# --------

# vi mode, of course :)
bindkey -v

# Widgets for tcsh like history behavior
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Search history up and down on the "up"
# and "down" arrow keys and on "k" and
# "j" in vi normal mode. Also bind the 
# raw key sequences to work around broken
# terminfo entries.
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey -a "k" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey -a "j" history-beginning-search-forward-end

# Bash-like incremental search on 'ctrl-r'
# in Insert mode. The same triggered on '/'
# in command mode. `up` and `down' for
# navigation.
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M isearch "${terminfo[kcuu1]}" history-incremental-search-backward
bindkey -M isearch "^[[A" history-incremental-search-backward
bindkey -M isearch "${terminfo[kcud1]}" history-incremental-search-backward
bindkey -M isearch "^[[B" history-incremental-search-forward

# Delete on 'del'
bindkey "${terminfo[kdch1]}" vi-delete-char

# Beginnig and end of line on 'home'
# and 'end'. For xterm, rxvt and the
# screen / tmux terminal.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "^[[H" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "^[[F" end-of-line

# Magic history completion on 'space'
bindkey ' ' magic-space

# Call 'man' on alt-h
bindkey '^[h' run-help

# Edit the current command line in $EDITOR.
autoload -z edit-command-line
zle -N edit-command-line
bindkey -a "^v" edit-command-line
