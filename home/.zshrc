# Path
export PATH="$HOME/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Sensible defaults
setopt autocd
setopt correct

# Aliases
alias ls="eza --icons"
alias ll="eza -lah --icons"
alias cat="bat"
alias grep="rg"