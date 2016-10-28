# Directory Stack
# ---------------

# 8 stack levels
DIRSTACKSIZE=8

# Make 'cd' an alias to 'pushd'
setopt AUTOPUSHD

# Swap meaning of 'cd +1' and 'cd -1'
setopt PUSHDMINUS

# Don't print stack after pushing
setopt PUSHDSILENT

# Push '~' when no parameter is given
setopt PUSHDTOHOME

