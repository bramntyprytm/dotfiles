# If you want to display fastfetch on shell startup
/opt/homebrew/bin/fastfetch

# No homebrew hints
HOMEBREW_NO_ENV_HINTS=1

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

alias cdm="codium"
alias cf="clear; fastfetch"
alias cl="clear"
alias config="~/.config"
alias ls="ls --color=auto"
alias ff="fastfetch"

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
zstyle ':fzf-tab:*' fzf-flags --color=bg+:#313244,bg:#000000,spinner:#f5e0dc,hl:#a6e3a1 \
  --color=fg:#cdd6f4,header:#a6e3a1,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#a6e3a1 \
  --color=selected-bg:#45475a --color=border:#313244,label:#cdd6f4

# fzf theme to match terminal colors
export FZF_DEFAULT_OPTS="
  --style=full
  --border
  --color=bg:#000000,bg+:#000000,preview-bg:#000000
  --color=fg:#cdd6f4,fg+:#cdd6f4
  --color=hl:#f38ba8,hl+:#f38ba8
  --color=border:#45475a,preview-border:#45475a
  --color=info:#a6adc8,prompt:#a6e3a1,pointer:#f5e0dc
  --color=marker:#f5e0dc,spinner:#f5e0dc,header:#89b4fa
"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up starship prompt
eval "$(starship init zsh)"
