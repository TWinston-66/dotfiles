# ~/.zshrc

# --- Homebrew ---
if [ -d /opt/homebrew/bin ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"      # macOS
elif [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"  # Linux
fi

# --- tmux ---
if [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  tmux && exit
fi

eval "$(fzf --zsh)"

# --- SSH agent ---
if [ -f "$HOME/.ssh/id_ed25519" ]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519" >/dev/null 2>&1
  elif command -v keychain >/dev/null 2>&1; then
    eval "$(keychain add --eval --quiet "$HOME/.ssh/id_ed25519")"
  fi
fi

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# --- Completion ---
if command -v brew >/dev/null 2>&1; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit && compinit

# --- Prompt ---
eval "$(starship init zsh)"

# --- Tools ---
eval "$(zoxide init zsh)"
if command -v brew >/dev/null 2>&1; then
  _fzf_keybindings="$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  [ -f "$_fzf_keybindings" ] && source "$_fzf_keybindings"
  unset _fzf_keybindings
fi

# --- tealdeer (tldr) ---
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer"

# --- Aliases ---
alias ls='eza --icons -a'
alias ll='eza -la --icons --git --header'
alias bat='bat --paging=never'
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'

export EDITOR="nvim"

export PATH="$HOME/.local/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/winstont/.local/bin:$PATH"
