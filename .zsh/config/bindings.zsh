# Bindings
# --------

# vi mode, of course :)
bindkey -v

# Widgets for tcsh like history behavior
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Don't require an whitespace after
# the cursor for completion
bindkey '^i' expand-or-complete-prefix

# Search history up and down on
# the "up" and "down" arrow keys.
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end

# Delete on 'del'
bindkey "${terminfo[kdch1]}" vi-delete-char

# Beginnig and end of line on 'home'
# and 'end'. For xterm, rxvt and the
# screen / tmux terminal.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Magic history completion on 'space'
bindkey ' ' magic-space

# Call 'man' on alt-h
bindkey '^[h' run-help

