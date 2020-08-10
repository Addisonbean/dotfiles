# Misc. Settings {{{

# TODO: explain everything w/ comments...

autoload -Uz colors && colors

fpath+=(~/.config/zsh/completions)
zmodload zsh/complist
zstyle ':completion:*' menu select
autoload -U compinit && compinit
setopt globdots

bindkey -r '^h'
# I can't get C-h mapped in menuselect mode...
bindkey -M menuselect '^h' vi-backwards-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

bindkey -v
# Recommended for vi mode, but what does it do???
# export KEYTIMEOUT=1

unsetopt share_history
setopt histignorespace

setopt correct
setopt extended_glob

bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search

bindkey "^k" up-line-or-search
bindkey "^j" down-line-or-search

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
alias xtheme="$HOME/.config/xthemes/xtheme.sh"

alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

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

eval "$(fasd --init auto)"
# Remove all the aliases except `z`
unalias a
unalias s
unalias d
unalias f
unalias sd
unalias sf
unalias zz

# }}}

# vim:foldmethod=marker:foldlevel=0
