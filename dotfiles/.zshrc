export PATH="/opt/homebrew:$PATH"

alias z='clear'
alias ls='lsd'
alias ll='ls -hal'
alias cat='bat'
alias p = 'procs'
alias rm='trash'

alias p='cd ~/Projects'
alias w='cd ~/Work'
alias art='cd ~/Art'
alias dn='cd ~/Downloads'
alias d='cd ~/Desktop'
alias cfg='cd ~/config'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'

export EDITOR="code --wait"
alias vim='nvim'

alias config:reload='darwin-rebuild switch --flake ~/config && source ~/.zshrc'
alias c:r='config:reload'
alias config:edit="$EDITOR ~/config"
alias c:e='config:edit'

#helpful functions
function mdcd() {
  mkdir -p $1 && cd $1
}
function mp() {
  cd ~/Projects && mkdir $1 && cd $1
}

function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="
--preview 'bat --color=always {}' \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--color=border:#363a4f,label:#cad3f5"
export FZF_DEFAULT_COMMAND="fd --type f"

source <(procs --gen-completion-out bash)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
