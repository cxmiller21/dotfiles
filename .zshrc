autoload -Uz compinit
compinit

setopt HIST_IGNORE_ALL_DUPS

# Devbox
DEVBOX_NO_PROMPT=true
eval "$(devbox global shellenv --init-hook)"

# Git
LANG=en_US.UTF-8

# Completions
source <(devbox completion zsh)
source <(docker completion zsh)
source <(kubectl completion zsh)

# Starship
eval "$(starship init zsh)"

# The Fuck
eval $(thefuck --alias)

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# kubecolor
compdef kubecolor=kubectl

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Zsh plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zstyle ':completion:*' menu yes select

# Aliases
alias ls='eza --long --all --no-permissions --no-filesize --no-user --no-time --git'
alias lst='eza --long --all --no-permissions --no-filesize --no-user --git --sort modified'
alias fzfp='fzf --preview \"bat --style numbers --color always {}\"'
alias cat='bat --paging never --theme DarkNeon --style plain'
alias kubectl='kubecolor'

export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Custom
alias cl='clear'
alias fk='fuck' # thef... alias
alias home='cd ~/'

# Git aliases
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Docker aliases
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'
alias dcur='docker-compose up --remove-orphans'

# Terraform aliases
alias ti='terraform init'
alias tfm='terraform fmt'
alias tv='terraform validate'
alias tp='terraform plan'
alias ta='terraform apply'

# Terragrunt aliases
alias tgi='terragrunt init'
alias tgfm='terragrunt fmt'
alias tgv='terragrunt validate-inputs'
alias tgp='terragrunt plan'
alias tga='terragrunt apply'

# Nav Aliases
alias cdgh='cd /Users/cooper.miller/Development/Strib'
