# Misc. Settings {{{

autoload -Uz colors && colors

zmodload zsh/complist
zstyle ':completion:*' menu select
autoload -U compinit && compinit
# export ZLS_COLORS="no 30;37:fi 30;37"

# TODO: explain these lines in comments...

bindkey -v

unsetopt share_history
setopt histignorespace

setopt correct
setopt extended_glob

bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search

bindkey "^k" up-line-or-search
bindkey "^j" down-line-or-search

# unalias l
# unalias ll
# unalias la
# unalias lsa

# alias untar="tar -xvzf"

# [[ "$ZSHRC_LOADED" == "true" ]] || fortune | cowsay
# ZSHRC_LOADED="true"

alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

alias ls="ls --color"
alias grep="grep --color"
alias feh="feh --no-fehbg"
alias less="less -R"

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias git-dot='git --git-dir=$HOME/.git-dotfiles/ --work-tree=$HOME'

# }}}
# {{{ Theme

# Adapted from: https://github.com/slashbeast/conf-mgmt/blob/master/roles/home_files/files/DOTzshrc#L208
function set_git_prompt() {
	# if [ "$PWD" = "$HOME" ]; then
	# 	unset git_prompt
	# 	return
	# fi
	
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		unset git_prompt
		return
	fi

	local git_status_dirty git_branch

	if [ "$(git --no-optional-locks status --untracked-files='no' --porcelain)" ]; then
		git_status_dirty=' %F{red}*'
	else
		unset git_status_dirty
	fi

	git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
	git_branch="${git_branch#refs/heads/}"

	git_branch="${git_branch:-no branch}"

	git_prompt="(${git_branch}${git_status_dirty}%f)"

	# return "$git_prompt"
}

# add-zsh-hook precmd set_git_prompt

# modified "simple" theme from oh-my-zsh
export PROMPT="%F{blue}%1~%f${git_prompt} "
export LS_COLORS="di=34:ln=35:so=33:pi=33:ex=31:bd=33:cd=33:su=37:sg=37:tw=37:ow=37"

# export LSCOLORS="gxfxcxdxbxegedabagacad"
# export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# }}}
# Exports, path changes, and software-setup {{{

export PATH="${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin:$PATH"
export PATH="${CABAL_DIR}/bin:$PATH"

# [ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
#
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
# 	eval "$(pyenv init -)"
# fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(fasd --init auto)"

# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH="$HOME/.idris2/bin:$PATH"

# export SPICETIFY_INSTALL="/home/addison/spicetify-cli"
# export PATH="$SPICETIFY_INSTALL:$PATH"

# }}}

# vim:foldmethod=marker:foldlevel=0
