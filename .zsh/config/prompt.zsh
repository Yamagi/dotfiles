# Prompt
# ------

# Left prompt. This deserves some explantion: We want
# a small indicator for the current vi mode. '+' is
# insert mode and '-' is command mode. The shell starts
# in insert mode, so the standard prompt is +'. Whenever
# the mode is changed or a new line is began zsh calls
# 'zle-line-init' or 'zle-keymap-select'. So we register
# both function, evaluate the current state of the KEYMAP
# variable to determine the mode.
PS1='%n@%m:%l + %(4~|.../%3~|%~)%(!|>|:) '

function zle-line-init zle-keymap-select {
	PS1="%n@%m:%l ${${KEYMAP/vicmd/-}/(main|viins)/+} %(4~|.../%3~|%~)%(!|>|:) "
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Second level prompt
PS2='%_> '

# Third level prompt
PS3='?# '

# Forth level prompt
PS4='+ '

# Right prompt
RPS1="[%*]"
