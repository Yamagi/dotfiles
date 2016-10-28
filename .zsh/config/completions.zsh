# Completions
# -----------

# Create the cache dir
if [[ ! -e ~/.zsh/run/completion_cache ]] ; then
	mkdir -p ~/.zsh/run/completion_cache
fi

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
zstyle ':completion:*:default' list-colors 'di=36:ln=35:so=32:pi=33:ex=31:bd=34;44:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

