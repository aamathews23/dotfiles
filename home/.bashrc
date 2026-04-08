# Path
export PATH="$HOME/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Brew
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null || true)"

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash --cmd cd)"
fi

# FZF
if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
fi

if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# pnpm
export PNPM_HOME="/home/aamathews/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end