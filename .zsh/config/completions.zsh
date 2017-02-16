# Completions
# -----------

# Create the cache dir
if [[ ! -e ~/.zsh/run/completion_cache ]] ; then
	mkdir -p ~/.zsh/run/completion_cache
fi

# Path to our custom completions
fpath=(~/.zsh/completions $fpath)

# Load the completion plugin
autoload -U compinit

# And initialize completions
compinit

# Print a new prompt and don't reuse the last one
unsetopt ALWAYS_LAST_PROMPT

# Don't insert the first match at second <tab>
unsetopt AUTO_MENU 

# Do not indicate file types
unsetopt LIST_TYPES

# Caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/completions

# The same colors as in normal 'ls' output
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Complete . and ..
zstyle ':completion:*' special-dirs true

# Complete files regardless of type on ctrl-x
_complete_files () {
	eval "$_comp_setup"
	_main_complete _files
}
compdef -k _complete_files complete-word '^x'

