# History
# -------

# Our history file
HISTFILE=~/.zsh/run/history

# Save last 4096 commands
SAVEHIST=4096

# Share history between instances
setopt SHARE_HISTORY

# Extended history format, incompatible
# with other shells. Necessary for some
# command like 'history -D'.
setopt EXTENDED_HISTORY

# Save duplicated lines only once
setopt HIST_IGNORE_ALL_DUPS

# If duplicate lines have been saved,
# still show them only once.
setopt HIST_FIND_NO_DUPS

# Don't save excessive whitespaces
setopt HIST_REDUCE_BLANKS

# Don't beep when reaching the histories end
setopt NO_HIST_BEEP

