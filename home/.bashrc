# Path
export PATH="$HOME/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PNPM
# export PNPM_HOME="$HOME/.local/share/pnpm"
# export PATH="$PNPM_HOME:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

# Brew
if command -v brew &> /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null || true)"
fi

# FZF
if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
fi

if [ -f ~/.aliases ]; then
  . ~/.aliases
fi
