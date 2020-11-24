export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="chromium"
export MANPAGER="nvim +Man!"
export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
source "$HOME/.config/user-dirs.dirs"
export XDG_DESKTOP_DIR
export XDG_DOCUMENTS_DIR
export XDG_DOWNLOAD_DIR
export XDG_MUSIC_DIR
export XDG_PICTURES_DIR
export XDG_PUBLICSHARE_DIR
export XDG_TEMPLATES_DIR
export XDG_VIDEOS_DIR

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export GHCUP_INSTALL_BASE_PREFIX="$XDG_DATA_HOME"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"

export LESSHISTFILE="/dev/null"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export _FASD_DATA="$XDG_CACHE_HOME/fasd/history"

[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
