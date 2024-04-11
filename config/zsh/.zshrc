#!/usr/bin/env zsh

setopt AUTO_CD # no need to use cd to navigate to folder

setopt AUTO_PUSHD # push the old directory onto the stack
setopt PUSHD_IGNORE_DUPS # do not store duplicates
setopt PUSHD_SILENT # do not print the directory stack after pushd or popd

# Globbing

setopt CORRECT # spell correct
setopt EXTENDED_GLOB # use extended globbing syntax
setopt NO_CASE_GLOB # set case-insensitive
setopt GLOB_COMPLETE # do not automatically complete globs (look into this)

# History TODO: think if I want duplicates or not

setopt SHARE_HISTORY # share history between multiple zsh sessions
setopt APPEND_HISTORY # append to history instead of overwriting
setopt INC_APPEND_HISTORY # add commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST # remove duplicates first from history
setopt HIST_IGNORE_DUPS # do not save duplicates
setopt HIST_FIND_NO_DUPS # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS # remove blank lines from history
setopt HIST_VERIFY # verify history shortcuts before sending

# Aliases

source $ZDOTDIR/aliases

# Autocomplete 

autoload -U compinit; compinit
_comp_options+=(globdots) # with hidden files
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Rust

source "$HOME/.cargo/env"

# NVM

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Ruby

eval "$(rbenv init - zsh)"

# Prompt

source $ZDOTDIR/prompt

# bun completions
[ -s "/Users/carlerikjohan/.bun/_bun" ] && source "/Users/carlerikjohan/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/carlerikjohan/.config/local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"