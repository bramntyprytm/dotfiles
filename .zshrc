# /opt/homebrew/bin/fastfetch

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

alias cl="clear"
alias cf="clear; fastfetch"
alias ls="ls --color=auto"
alias fvim="fzf-tmux -p --reverse | xargs -o vim"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Disable homebrew auto-update
HOMEBREW_NO_AUTO_UPDATE=1

# Change fzf theme to catppuccin mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1f1f1f,spinner:#f5e0dc,hl:#a6e3a1 \
--color=fg:#cdd6f4,header:#a6e3a1,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#a6e3a1 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up starship prompt
eval "$(starship init zsh)"

# Change alacritty title bar
preexec() { print -Pn "\e]0;$1\a" }
