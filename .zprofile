export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="google-chrome-stable"
export MANPAGER="nvim +Man!"
export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export GHCUP_INSTALL_BASE_PREFIX="$XDG_DATA_HOME"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"

export LESSHISTFILE="/dev/null"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export _FASD_DATA="$XDG_CACHE_HOME/fasd/history"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
