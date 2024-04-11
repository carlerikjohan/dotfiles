export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export EDITOR="nvim"
export VISUAL="nvim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# Rust

. "$HOME/.cargo/env"

# NVM
export NVM_DIR="$HOME/.nvm"

# Bun (https://bun.sh/)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Ruby
export DISABLE_SPRING=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"

# Teamtailor
export LDFLAGS="-L/opt/homebrew/opt/openssl@3.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3.0/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3.0/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3.0)"
export PATH="/opt/homebrew/opt/openssl@3.0/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
