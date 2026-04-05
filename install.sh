#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

echo "==> Detecting environment..."

if grep -qi microsoft /proc/version 2>/dev/null; then
  PLATFORM="WSL"
elif [[ "$OS" == "Darwin" ]]; then
  PLATFORM="MAC"
else
  PLATFORM="LINUX"
fi

echo "==> Platform detected: $PLATFORM"

echo "==> Updating brew..."
brew update

echo "==> Installing CLI tools from Brewfile..."
brew bundle --file="$REPO_DIR/Brewfile"

#######################################
# Install VS Code (macOS and Linux only)
#######################################

if [[ "$PLATFORM" == "MAC" ]] || [[ "$PLATFORM" == "LINUX" ]]; then
  if ! command -v code &> /dev/null; then
    echo "==> Installing VS Code..."
    brew install --cask visual-studio-code
  fi
fi

#######################################
# Symlink dotfiles
#######################################

echo "==> Applying dotfiles..."

for file in "$REPO_DIR"/home/.*; do
  filename=$(basename "$file")
  target="$HOME/$filename"

  if [[ "$filename" == "." || "$filename" == ".." ]]; then
    continue
  fi

  if [[ "$filename" == ".zshrc" && "$SHELL" != *"zsh"* ]]; then
    echo "Skipping .zshrc since current shell is not zsh"
    continue
  fi

  if [[ "$filename" == ".bashrc" && "$SHELL" != *"bash"* ]]; then
    echo "Skipping .bashrc since current shell is not bash"
    continue
  fi

  if [[ -e "$target" && ! -L "$target" ]]; then
    if [[ "$target" == "$HOME/.zshrc" || "$target" == "$HOME/.bashrc" ]]; then
      echo "Backing up existing file: $target to $target.bak"
      mv "$target" "$target.bak"
      ln -sf "$file" "$target"
    else
      echo "Skipping existing file: $target"
    fi
  else
    ln -sf "$file" "$target"
  fi
done

#######################################
# Install nvm
#######################################

if [ ! -d "$HOME/.nvm" ]; then
  echo "==> Installing nvm..."
  PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash'
fi

#######################################
# Install pnpm
#######################################

if ! command -v pnpm &> /dev/null; then
  echo "==> Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

#######################################
# Install rustup
#######################################

if ! command -v rustup &> /dev/null; then
  echo "==> Installing rustup..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
fi

#######################################
# Install VS Code Extensions
#######################################

if command -v code &> /dev/null; then
  echo "==> Installing VS Code extensions..."
  installed=$(code --list-extensions)

  while read -r extension; do
    if ! echo "$installed" | grep -q "$extension"; then
      echo "Installing $extension"
      code --install-extension "$extension"
    fi
  done < "$REPO_DIR/vscode/extensions.txt"
else
  echo "VS Code CLI not found. Skipping extension install."
fi

echo ""
echo "✅ Setup complete. Restart your shell."
