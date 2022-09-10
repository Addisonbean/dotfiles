# Misc. Settings {{{

# TODO: explain everything w/ comments...

autoload -Uz colors && colors

fpath+=(~/.config/zsh/completions)
zmodload zsh/complist
zstyle ':completion:*' menu select
autoload -U compinit && compinit
setopt globdots

# bindkey -r '^h'
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
setopt interactive_comments

bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search

bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search

alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

alias ls="ls --color"
alias grep="grep --color"
alias feh="feh --no-fehbg"
alias less="less -R"
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

autoload -Uz add-zsh-hook
setopt prompt_subst

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias git-dot='git --git-dir=$HOME/.git-dotfiles/ --work-tree=$HOME'
alias xtheme="$HOME/.config/xthemes/xtheme.sh"
alias x="xdg-open"

# }}}
# {{{ Prompt

# Adapted from: https://github.com/slashbeast/conf-mgmt/blob/master/roles/home_files/files/DOTzshrc#L208
# TODO: indicate if in a rebase or merge
function set_git_prompt() {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		unset git_prompt
		return
	fi

	local git_status_dirty git_branch

	if [ "$(git --no-optional-locks status --untracked-files='no' --porcelain)" ]; then
		git_status_dirty=' %F{red}x%f'
	else
		unset git_status_dirty
	fi

	git_branch="$(git symbolic-ref HEAD 2> /dev/null)"
	git_branch="${git_branch#refs/heads/}"
	git_commit="$(git rev-parse --short HEAD 2> /dev/null)"
	git_branch="${git_branch:-$git_commit}"

	git_prompt="(${git_branch}${git_status_dirty})"
}

add-zsh-hook precmd set_git_prompt

# Modified "simple" theme from oh-my-zsh
export PROMPT="%F{blue}%1~%f\${git_prompt} "
export LS_COLORS="di=34:ln=35:so=33:pi=33:ex=31:bd=33:cd=33:su=37:sg=37:tw=37:ow=37"

# }}}
# Exports, path changes, and software-setup {{{

export PATH="${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin:$PATH"
export PATH="${CABAL_DIR}/bin:$PATH"

export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"

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
