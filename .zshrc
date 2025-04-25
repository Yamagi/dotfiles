# Ensure that the runtime dir exists.
if [[ ! -e ~/.zsh/run ]] ; then
	mkdir -p ~/.zsh/run
fi

# Force an umask of "027" for unprivileged users.
# root must have the standard umask, otherwise
# packet installations and the like will mess up.
if [[ "$LOGNAME" != "root" ]] ; then
	umask 022
fi

# Set the final PATH.
path=($_local_path $path)

# --------

# General settings.
() {
	# Blue directories are hard to read. Change them
	# to cyan. BSD, Linux and commercial Unixes have
	# different variables for that.
	if [[ $_os == "FreeBSD" ]] ; then
		export LSCOLORS=gxfxcxdxbxeDedabagacad
	else
		export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;1;43:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
	fi

	# ----

	# Save the last 8 dir on the dir stack.
	DIRSTACKSIZE=8

	# 'cd' should push to dir stack, just like 'pushd'.
	setopt AUTOPUSHD

	# Swap meaning of 'cd +1' and 'cd -1'.
	# It's more intuitive this way.
	setopt PUSHDMINUS

	# Don't print the dir stack after pushing.
	setopt PUSHDSILENT

	# Push '~' when no parameter is given.
	# This makes 'cd' behave consistently.
	setopt PUSHDTOHOME

	# ----

	# Correct commands.
	setopt CORRECT

	# Allow comments in interactive shells.
	setopt INTERACTIVE_COMMENTS

	# Print runtime of commands which
	# took longer than 1 second.
	REPORTTIME=1

	# Print exit code if it's non-zero.
	setopt PRINT_EXIT_VALUE
}

# --------

# Aliases.
() {
	# Always colorful 'ls'.
	if [[ $_os == "FreeBSD" ]] ; then
		alias ls='ls -G'
	else
		alias ls='ls --color'
	fi

	# 'd' as shortcut to 'dirs -v'
	alias d='dirs -v'

	# Special git tree for the dotfiles.
	alias dotfiles='git --work-tree=${HOME} --git-dir=${HOME}/.dotfiles'

	# Get an up to date env from tmux.
	alias fixenv='eval $(tmux showenv -s)'

	# 'll' as a convenient long ls.
	alias ll='ls -lha'

	# Force su to always start in a clean environment.
	alias su='su -l'
}

# --------

# Completion.
() {
	# Initialize the completion subsystem.
	autoload -U compinit
	compinit -d ~/.zsh/run/compdump

	# Allow completions to cache results.
	if [[ ! -e ~/.zsh/run/completion_cache ]] ; then
		mkdir -p ~/.zsh/run/completion_cache
	fi
	zstyle ':completion:*' use-cache on
	zstyle ':completion:*' cache-path ~/.zsh/run/completion_cache

	# Rehash before executing external completions.
	# Ensures that all directory in PATH are up to
	# date.
	zstyle ':completion:*' rehash true

	# use same colors as in normal 'ls' output.
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

	# Complete . and ..
	zstyle ':completion:*' special-dirs true

	# Treat // in pathes like a single /. This is
	# the normal Unix behavior. Otherwise // is
	# treated like /*/.
	zstyle ':completion:*' squeeze-slashes true

	# Always print a new prompt when listing completions.
	# Otherwise the old prompt would be reused.
	unsetopt ALWAYS_LAST_PROMPT

	# Don't use a menu to list and select completions.
	unsetopt AUTO_MENU

	# Don't indicate file types by adding a suffix.
	# Instead we are using colors as indicator.
	unsetopt LIST_TYPES

	# Path for user defined completions.
	if [[ ! -e ~/.zsh/completions ]] ; then
		mkdir -p ~/.zsh/completions
	fi
	fpath=(~/.zsh/completions $fpath)

	# Complete files regardless of type on CTRL-x.
	_complete_files () {
		eval "$_comp_setup"
		_main_complete _files
	}
	compdef -k _complete_files complete-word '^x/'
}

# --------

# Cursor.
() {
	# Track the last selected mode. New shells start
	# in command mode.
	typeset -g _last_mode=vicmd

	# Helper functions.
	function _set_block_cursor() {
		echo -ne '\e[2 q'
	}
	function _set_beam_cursor() {
		echo -ne '\e[6 q'
	}

	# Define a custom zle-keymap-select widget and
	# use it to change the cursor shape depending
	# on the current keymap and to track the last
	# selected mode. If the selected keymap is
	# 'vicmd' we are in command mode. Otherwise
	# input mode is assumed.
	function zle-keymap-select {
		if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
			_set_block_cursor
			_last_mode=vicmd
		else
			_set_beam_cursor
			_last_mode=viins
		fi
	}
	zle -N zle-keymap-select

	# Make sure that a new prompt starts in the last
	# selected mode. Since we are always changing
	# the keymap when entering the line editor,
	# even when the current and new keymap are the
	# same, zle-keymap-select is guaranteed to be
	# called. This ensures that the cursor has the
	# correct shape.
	zle-line-init() { zle -K $_last_mode }
	zle -N zle-line-init

	# Switch to block cursor when a command starts
	# executing. This prevents some problems with
	# programs which implement their own cursor
	# handling. For example Vim assumes that it
	# resumes with a block cursor.
	preexec_functions+=(_set_block_cursor)

	# The same when exiting the shell, because an
	# underlying shell might assume an unchanged
	# cursor.
	zshexit_functions+=(_set_block_cursor)
}

# --------

# History.
() {
	# History file.
	HISTFILE=~/.zsh/run/history

	# Save up to 8192 commands in the history file. Keep
	# 8192 + 2048 = 10240 in memory. Excessive commands are
	# lost when the shell process exists.
	SAVEHIST=8192
	HISTSIZE=10240

	# Don't beep when trying to access a nonexistent entry.
	# An example is the beep when the end of the history is
	# reached.
	unsetopt HIST_BEEP

	# When searching the history show duplicated entries
	# only once at first match. This is effectively a no-
	# op, because we trim duplicate commands from the
	# history.
	setopt HIST_FIND_NO_DUPS

	# If a new command line being added to the history
	# duplicates an older one, the older command is
	# removed.
	setopt HIST_IGNORE_ALL_DUPS

	# Remove superfluous blanks from each command added
	# to the history.
	setopt HIST_REDUCE_BLANKS

	# Share the history between all running instances.
	# Implies EXTENDED_HISTORY and INC_APPEND_HISTORY.
	setopt SHARE_HISTORY
}

# --------

# Key bindings.
() {
	# Enable vi mode.
	bindkey -v

	# Edit the current command line in $EDITOR.
	autoload -z edit-command-line
	zle -N edit-command-line
	bindkey -M vicmd 'ge' edit-command-line

	# Search history up and down on the 'up' and 'down' arrow keys.
	# Also bind the raw key sequences to work around broken terminfo
	# entries.
	autoload -U history-search-end
	zle -N history-beginning-search-backward-end history-search-end
	zle -N history-beginning-search-forward-end history-search-end
	bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
	bindkey '^[[A' history-beginning-search-backward-end
	bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
	bindkey '^[[B' history-beginning-search-forward-end

	# Bash-like incremental search on 'ctrl-r' in insert mode. The
	# same behavior is triggered on '/' in command mode. 'up' and
	# `down' arrow keys for navigation.
	bindkey -M viins '^R' history-incremental-search-backward
	bindkey -M vicmd '/' history-incremental-search-backward
	bindkey -M isearch "${terminfo[kcuu1]}" history-incremental-search-backward
	bindkey -M isearch '^[[A' history-incremental-search-backward
	bindkey -M isearch "${terminfo[kcud1]}" history-incremental-search-backward
	bindkey -M isearch '^[[B' history-incremental-search-forward

	# Delete on 'del'
	bindkey "${terminfo[kdch1]}" vi-delete-char

	# Beginning and end of line on 'home' and 'end'. As above also
	# bind the raw key·sequences to work around broken terminfo
	# entries.
	bindkey "${terminfo[khome]}" beginning-of-line
	bindkey '^[[H' beginning-of-line
	bindkey "${terminfo[kend]}" end-of-line
	bindkey '^[[F' end-of-line

	# Magic history completion on 'space'.
	bindkey ' ' magic-space
}

# --------

# Prompt.
() {
	# First level prompt. It's always preceded by the
	# OSC 133 prompt marker sequence. It can be used
	# by the terminal for integrations like 'jump to
	# previous or next prompt'.
	PS1=$'%{\e]133;A\e\\%}'
	PS1+='%n@%m:%l %(4~|.../%3~|%~)%(!|>|:) '

	# Second level prompt.
	PS2='%_> '

	# Third level prompt.
	PS3='?# '

	# Forth level prompt.
	PS4='+ '

	# Right prompt.
	RPS1="[%*]"
}
