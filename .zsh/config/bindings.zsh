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
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# Delete on 'del'
bindkey '^[[3~' vi-delete-char

# Beginnig and end of line 
# on 'home' and 'end'.
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line

# Magic history completion on 'space'
bindkey ' ' magic-space

# Call 'man' on alt-h
bindkey '^[h' run-help

