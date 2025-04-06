export PATH="/opt/homebrew:$PATH"

alias z='clear'
alias ls='lsd'
alias ll='ls -hal'
alias cat='bat'

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

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
