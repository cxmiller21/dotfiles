autoload -Uz compinit
compinit

# Devbox
DEVBOX_NO_PROMPT=true
source <(devbox completion zsh)

# Starship
eval "$(starship init zsh)"

# Zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zstyle ':completion:*' menu yes select
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(thefuck --alias)

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias ls='eza --long --all --no-permissions --no-filesize --no-user --no-time --git --colour always'
alias fzfp='fzf --preview \"bat --style numbers --color always {}\"'