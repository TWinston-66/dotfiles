# ~/.zshrc

# --- Homebrew ---
if [ -d /opt/homebrew/bin ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"      # macOS
elif [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"  # Linux
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

# --- Aliases ---
alias ls='eza --icons'
alias ll='eza -la --icons'
alias cat='bat'
alias g='git'
alias vim='nvim'

export PATH="$HOME/.local/bin:$PATH"
